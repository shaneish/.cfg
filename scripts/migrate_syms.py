from pathlib import Path
from pprint import pprint as pp
import os

# %%

valid_syms = [ # pulled using `fd -tl` cli command, inserted using vim ":read" functionality in normal mode: `:r !fd -tl`
    "agents/cursor-agent/cursor-sesh",
    "background.png",
    "bin/theme",
    "fish/active_theme.theme",
    "fish/themes/active_theme.theme",
    "fish/themes/theme.theme",
    "kitty/theme.conf",
    "nvim/active_theme.vim",
    "nvim/theme.vim",
    "starship-prompts/starship-minimal.toml",
    "starship-prompts/starship.toml",
    "starship.toml",
    "waybar/config",
    "waybar/waybar",
    "wezterm/colors/active_theme.toml",
    "wezterm/colors/theme.toml",
]

# %%

symlinks = []
dropped = []
for path in Path('.').rglob('*'):
    if path.is_symlink(): # and path.is_absolute():
        if any(sym in str(path) for sym in valid_syms) or path.is_absolute():
            link = path.absolute()
            link_source = path.resolve()
            link_dir, link_name = link.parent, link.name
            if not (link_source / link_name).exists():
                if "/.cfg/" in str(link_source):
                    link_source = Path(str(link_source).split("/.cfg/")[1]).absolute()
                elif "/.config/" in str(link_source):
                    link_source = Path(str(link_source).split("/.config/")[1]).absolute()
                if not link_source.exists():
                    raise FileNotFoundError(f"Link source {link_source} does not exist for link {link}")
            rel_to_link = link_source.relative_to(link_dir, walk_up=True)
            package = {"cd": link_dir, "link": link_name, "target": rel_to_link, "link_source": link_source, "raw": path}
            if ("/home/" in str(link_source)) or (str(link_source).startswith("/Users/")):
                symlinks.append(package)
            else:
                dropped.append(package)

print(f"Found {len(symlinks)} symlinks to migrate:")
pp(symlinks)

print(f"\nDropped {len(dropped)} symlinks:")
pp(dropped)

# %%

for idx, sym in enumerate(symlinks):
    if not str(sym["target"]).startswith("."):
        rel_to_link_adj = f"./{sym['target']}"
    else:
        rel_to_link_adj = str(sym["target"])
    if not (sym['cd'] / sym['link']).exists():
        print("--- odd --->")
    # print(f"link {sym['link']} in {sym['cd']}: {(sym['cd'] / sym['link']).exists()}")
    print(f"[{idx}]: cd {sym['cd']} && ln -s {rel_to_link_adj} {sym['link']}")
    os.chdir(sym["cd"])
    rel_to_link_adj = Path(rel_to_link_adj)
    if rel_to_link_adj.exists():
        print(f"Creating symlink in {Path('.').absolute()}: {sym['link']} -> {rel_to_link_adj}")
        try:
            os.symlink(rel_to_link_adj, sym["link"])
        except FileExistsError:
            os.remove(sym["link"])
            os.symlink(rel_to_link_adj, sym["link"])


