#!/usr/bin/env python3

from argparse import ArgumentParser
from pathlib import Path
from os import system
import tomllib


CONFIG_DIR = Path.home() / ".config"
COLORS_DIR = CONFIG_DIR / "colors"
ACTIVE_THEME_NAME = "theme"
THEME_APP_MAP = {
    "fish.theme": CONFIG_DIR / "fish" / "themes",
    "nvim.vim": CONFIG_DIR / "nvim",
    "wezterm.toml": CONFIG_DIR / "wezterm" / "colors",
    "starship.toml": CONFIG_DIR / "starship-prompts",
    "starship-minimal.toml": CONFIG_DIR / "starship-prompts",
}
UNNAMED_THEMES = ["starship.toml", "starship-minimal.toml"]


def unthread(d: dict, h: str | None = None):
    l = []
    for k, v in d.items():
        key = f"{h}.{k}" if h else str(k)
        if isinstance(v, dict):
            l = l + unthread(v, key)
        else:
            l.append((key, v))
    return l


def link_unlink(source: Path, target: Path):
    target.unlink(missing_ok=True)
    target.symlink_to(source, target_is_directory=False)


def build(input, spec_dir, template_dir, themes_dir):
    spec_file = spec_dir / input
    with open(spec_file, "rb") as f:
        spec = tomllib.load(f)
    flat_spec = unthread(spec)

    for template_path in template_dir.glob("*.tmpl"):
        with open(template_path, "r") as f:
            template = f.read()
            for key, value in flat_spec:
                template = template.replace("{{" + key + "}}", str(value).lstrip("#"))
        template_name_stripped = template_path.stem
        theme_name = spec_file.stem
        output_dir = themes_dir / theme_name
        output_dir.mkdir(parents=True, exist_ok=True)
        output_file = output_dir / template_name_stripped
        with open(output_file, "w") as f:
            f.write(template)
        print(f"Created theme {theme_name} from spec {spec_file} at {output_file}")


def switch(input, themes_dir, theme_referent):
    theme_dir = themes_dir / input
    for theme_file in theme_dir.glob("*"):
        if theme_file.name not in THEME_APP_MAP:
            print(f"Skipping unsupported theme file: {theme_file.name}")
            continue

        if theme_file.name in UNNAMED_THEMES:
            target = THEME_APP_MAP[theme_file.name] / theme_file.name
        else:
            target = THEME_APP_MAP[theme_file.name] / f"{theme_referent}.{theme_file.suffix.lstrip('.')}"
        if not target.parent.exists():
            target.parent.mkdir(parents=True, exist_ok=True)
        try:
            link_unlink(theme_file, target)
        except Exception as e:
            print(f"Failed to link {theme_file} to {target}: {e}")
        else:
            match theme_file.name:
                case "fish.theme":
                    system(f"fish -c 'fish_config theme choose {theme_referent}; yes | fish_config theme save;'")
                case "starship.toml":
                    system("aesthetic_switcher 0")
                    system("aesthetic_switcher 0")


def list(themes_dir):
    for theme in themes_dir.glob("*"):
        if theme.is_dir():
            print(theme.name)


if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument("action", help="Action to perform (build, switch, list)")
    parser.add_argument("input", nargs="?", help="Action input field")
    parser.add_argument("-t", "--template_dir", help="Templates directory")
    parser.add_argument("-s", "--spec_dir", help="Specs directory")
    parser.add_argument("-T", "--themes_dir", help="Themes directory")
    parser.add_argument("-n", "--theme_referent", help="Name of the theme to switch to", default=ACTIVE_THEME_NAME)
    args = parser.parse_args()

    template_dir = COLORS_DIR / "templates"
    if args.template_dir:
        template_dir = Path(args.template_dir)

    themes_dir = COLORS_DIR / "themes"
    if args.themes_dir:
        themes_dir = Path(args.themes_dir)

    spec_dir = COLORS_DIR / "specs"
    if args.spec_dir:
        spec_dir = Path(args.spec_dir)

    if not themes_dir.exists() or not themes_dir.is_dir():
        print(f"Theme location {themes_dir} does not exist or is not a directory.")
        exit(1)

    match args.action:
        case "build":
            build(args.input, spec_dir, template_dir, themes_dir)
        case "switch":
            switch(args.input, themes_dir, args.theme_referent)
        case "list":
            list(themes_dir)
