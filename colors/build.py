#!/usr/bin/env python3

from argparse import ArgumentParser
from pathlib import Path
import tomllib


def unthread(d: dict, h: str | None = None):
    l = []
    for k, v in d.items():
        key = f"{h}.{k}" if h else str(k)
        if isinstance(v, dict):
            l = l + unthread(v, key)
        else:
            l.append((key, v))
    return l


if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument("spec", help="Input spec file")
    parser.add_argument("-t", "--template_dir", help="Templates directory")
    parser.add_argument("-s", "--spec_dir", help="Specs directory")
    parser.add_argument("-T", "--themes_dir", help="Themes directory")
    args = parser.parse_args()

    spec_file = Path.cwd() / "specs" / args.spec
    if args.spec_dir:
        spec_file = Path(args.spec_dir) / args.spec

    template_dir = Path.cwd() / "templates"
    if args.template_dir:
        template_dir = Path(args.template_dir)

    themes_dir = Path.cwd() / "themes"
    if args.themes_dir:
        themes_dir = Path(args.themes_dir)

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

