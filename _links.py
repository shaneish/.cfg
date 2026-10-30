#!/bin/env python3
from pathlib import Path
import sys

# TO__* means a direct link should be made
# IN__* means the a recursive link to all files _in_ the directory should be made
#   (similar to the difference between `cp from_dir/ to_dir/` and `cp -r from_dir/* to_dir/`)
# FROM_TO__* means that the iterator should setup a direct symlink to the same single target for every element
# FROM_IN__* means that the iterator should setup recursive links to everything inside the same target dir for every element
#
# *__HOME represents the ~/ directory
# *__HOME__DOT_CONFIG represents the ~/.config directory
# *__HOME__DOT_CONFIG__DOT_CFG represents the ~/.config/.cfg directory
# *__HOME__PROJECTS represents the ~/Projects (or ~/projects or ~/PROJECTS matching in that order) directory
# *__ROOT__TMP represents the /tmp directory
# ...etc...

TO__HOME__DOT_CONFIG = [
    "nvim",
    "fish",
    "karabiner",
    "sketchybar",
    "waybar",
    "sway",
    "yazi",
    "wezterm",
    "wofi",
    "rofi",
    "hypr",
    "opencode",
    "nushell",
    "kitty",
    "glow",
    ".bhop",
    "starship.toml",
]
TO__HOME = [
    "nvim/.vimrc",
    "dots/.bashrc",
    "dots/.zshrc",
    "dots/.tmux.conf",
    "dots/.gitconfig",
    "aerospace.toml",
]
FROM_IN__HOME__DOT_CONFIG__DOT_CFG__AGENTS__SKILLS = { # k: v => link @ "~/{k}/{v}/*" for "agents/skills/*" directory
    ".claude": "skills",
    ".cursor": "skills-cursor"
}
IN__DOT_LOCAL__BIN = [
    "bin/",
]
IN__HOME__DEEPER = { # k: v => link @ "~/{v}/*" for "agents/{k}/*"
    "agents/cursor/": ".cursor",
    "agents/claude/": ".claude",
}
DIR__HOME = Path.home()
DIR__HOME__DOT_CONFIG = DIR__HOME / ".config"
DIR__HOME__DOT_LOCAL__BIN = DIR__HOME / ".local" / "bin"
this_cfg_dir = DIR__HOME__DOT_CONFIG / ".cfg"
if hasattr(sys, 'ps1'):
    cfg_dir = Path(__file__).resolve().parent


class Linker:
    def __init__(self):
        self.failed = []
        self.skipped = []
        self.success = []

    def link(self, _from: Path | str, _to: Path | str):
        _from, _to = Path(_from), Path(_to)
        if (not _from.exists()) and _from.is_symlink():
            _from.unlink(missing_ok=True)
        elif _from.exists():
            if _from.resolve() != _to.resolve():
                print(f"[warning] already existing file or link @ {_from}...")
                self.skipped.append((_from, _to, _to.resolve()))
            else:
                print(f"[info] link already exists: {_to} @ {_from}...")
        try:
            _from.symlink_to(_to)
            self.success.append((_from, _to))
            print(f"[info] successfully linked: {_to} @ {_from}...")
        except Exception as e:
            if _from.resolve() != _to.resolve():
                self.failed.append((_from, _to, e))
            else:
                print(f"[info] link already exists: {_to} @ {_from}...")

    def review(self):
        still_fucked = []
        for f, t, e in self.failed + self.skipped:
            answer = "no"
            if isinstance(e, Path):
                answer = input(f"\n> Already existing file or link @ {f} which resolves to {e}.  Overwrite it to point to {t}? [Y/n] >> ")
            else:
                answer = input(f"\n> Creating link @ {f} to {t} failed for error: {e}.  Overwrite? [Y/n] >> ")
            if answer.lower().startswith("y"):
                try:
                    f.unlink(missing_ok=True)
                    f.symlink_to(t)
                    self.success.append((f, t))
                    print(f"    [info] successfully fixed linked: {t} @ {f}...")
                except Exception as e:
                    still_fucked.append((f, t, e))
                    print(f"    [error] failed to fix link: {t} @ {f} for {e}...")
            else:
                self.skipped.append((f, t, e))
        self.failed = still_fucked


l = Linker()


for f in TO__HOME__DOT_CONFIG:
    link = DIR__HOME__DOT_CONFIG / f
    target = this_cfg_dir / f
    l.link(link, target)

for f in TO__HOME:
    link = Path.home() / Path(f).stem
    target = this_cfg_dir / f
    l.link(link, target)

for dir in IN__DOT_LOCAL__BIN:
    for target in Path(dir).iterdir():
        link = DIR__HOME__DOT_LOCAL__BIN / target.stem
        l.link(link, target)

for from_dir, to_dir in IN__HOME__DEEPER.items():
    for target in Path(from_dir).iterdir():
        target = this_cfg_dir / target
        link = DIR__HOME / to_dir / target.stem
        l.link(link, target)

for home_dir, skills_dir in FROM_IN__HOME__DOT_CONFIG__DOT_CFG__AGENTS__SKILLS.items():
    link_dir = DIR__HOME / home_dir / skills_dir
    link_dir.mkdir(parents=True, exist_ok=True)
    for target in (this_cfg_dir / "agents" / "skills").iterdir():
        link = link_dir / target.name
        l.link(link, target)

l.review()

# --- TODO --- #
# RUN: sh scripts/mac_nerd_fonts.sh
# RUN: sh ipython/_setup
# RUN: sh python-venvs/_setup # update to install and use `uv`
# special glazewm linkage
# special keyd linkage and setup
