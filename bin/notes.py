#!/usr/bin/env python3
import os
import tomllib
from argparse import ArgumentParser, Namespace
from dataclasses import dataclass
from inspect import cleandoc
from pathlib import Path
from datetime import datetime as dt


@dataclass
class Settings:
    EDITOR: str | None
    AUTHOR_NAME: str | None
    AUTHOR_EMAIL: str | None
    REPO_DIRECTORY: Path | str | None
    DEFAULT_TITLE: str | None
    NAME_PREFIX: str | None = "note"
    SECTIONS: list[str] = []
    SECTION_CASING: str | None = None
    TEMPLATE_CASING: str | None = None
    METADATA_CASING: str | None = None
    FILE_APPEND_DATE: bool | None = None # options: True, False, None
    ONLY_APPEND_UNNAMED_FILES: bool = True
    APPEND_DATE_FORMAT: str | None = "%Y%m%d-%H%M%S"
    DATE_FORMAT: str | None = "%Y-%m-%d"
    TEMPLATE_NAME: str | None = "default"


DEFAULT_TEMPLATE_ARGS = Settings(
    EDITOR="nvim",
    AUTHOR_NAME="shane stephenson",
    AUTHOR_EMAIL="stephenson.shane.a@gmail.com",
    REPO_DIRECTORY=Path.home() / "notes",
    NAME_PREFIX="notes",
    DEFAULT_TITLE="notes",
    SECTIONS=["context", "notes", "todo"],
    SECTION_CASING=None,
    TEMPLATE_CASING=None,
    METADATA_CASING=None,
    FILE_APPEND_DATE=True,
    ONLY_APPEND_UNNAMED_FILES=True,
    APPEND_DATE_FORMAT="%Y%m%d-%H%M%S",
    DATE_FORMAT="%Y-%m-%d",
    TEMPLATE_NAME="default",
)
NOTES_CONFIG_NAME = ".notes.toml"
TEMPLATES = {
    "default": {
        "extension": "md",
        "section_prefix": "## ",
        "template": cleandoc("""
            # {TITLE}
            ~~~
            subject:  {SUBJECT}
            author (email):   {AUTHOR_NAME} ({AUTHOR_EMAIL})
            created (revised):  {CREATION_DATE} ({REVISION_DATE})
            ~~~
            {SECTIONS}
        """),
    }
}


def pseudopath(p: Path | str | None = None, default_home: bool = False, directory_only: bool = False) -> Path:
    derived_p = Path.cwd()
    if isinstance(p, str):
        derived_p = Path(p)
    elif isinstance(p, Path):
        derived_p = p
    elif default_home:
        derived_p = Path.home()
    if directory_only and not derived_p.is_dir():
        derived_p = derived_p.parent
    return derived_p


def get_env_settings() -> dict[str, str | Path | list[str]]:
    env_settings = {k: os.getenv(f"NOTES__{k}") or v for k, v in Settings.__dataclass_fields__.items()}
    env_settings["EDITOR"] = env_settings.get("EDITOR") or env_settings.get("EDITOR")
    if isinstance(env_settings["REPO_DIRECTORY"], str):
        env_settings["REPO_DIRECTORY"] = Path(env_settings["REPO_DIRECTORY"])
    if isinstance(env_settings["SECTIONS"], str):
        env_settings["SECTIONS"] = [s.strip() for s in env_settings["SECTIONS"].split(",")]
    if isinstance(env_settings["FILE_APPEND_DATE"], str):
        env_settings["FILE_APPEND_DATE"] = env_settings["FILE_APPEND_DATE"].lower() in ("1", "true", "yes")
    if isinstance(env_settings["SECTION_CASING"], str):
        env_settings["SECTION_CASING"] = env_settings["SECTION_CASING"].lower() in ("1", "true", "yes")
    return env_settings


def get_config_settings(check_dirs: list[str | Path | None] | None = None) -> dict[str, str | Path | list[str]]:
    all_dirs = [pseudopath(default_home=True) / ".config"] + check_dirs if check_dirs else []
    for possible_cfg in [pseudopath(p, directory_only=True) / NOTES_CONFIG_NAME for p in all_dirs]:
        if possible_cfg.exists():
            with open(possible_cfg, "rb") as f:
                return tomllib.load(f)
    return {}


def get_arguments() -> Namespace:
    parser = ArgumentParser(
        prog="note",
        description="Create a notes file from a template and open it in your editor.",
    )
    parser.add_argument(
        "--name",
        "-n",
        type=str,
        help="name for notes file (without extension)",
    )
    parser.add_argument(
        "--directory",
        "-d",
        type=str,
        help="path to notes repo directory (overrides config and environment variables)",
    )
    parser.add_argument(
        "--file-path", "-f", type=str, help="optional file path to create note (overrides directory and name)."
    )
    parser.add_argument("--title", "-t", type=str, help="title for notes file")
    parser.add_argument("--subject", "-s", type=str, help="description for notes")
    parser.add_argument(
        "--author", "-a", type=str, help="author name"
    )
    parser.add_argument(
        "--email", "-E", type=str, help="author email"
    )
    parser.add_argument(
        "--template",
        "-T",
        type=str,
        choices=list(TEMPLATES.keys()),
        default="default",
        help="template to use for notes file",
    )
    parser.add_argument(
        "--sections",
        "-s",
        nargs="+",
        type=str,
        help="section titles for notes",
    )
    parser.add_argument(
        "--case-sections",
        "-cs",
        type=str,
        choices=["upper", "lower", "title", "sentence"],
        help="case for section titles (overrides config and environment variables)",
    )
    parser.add_argument(
        "--case-template",
        "-ct",
        type=str,
        choices=["upper", "lower", "title", "sentence"],
        help="case for non-title and non-metadata sections (overrides config and environment variables)",
    )
    parser.add_argument(
        "--case-metadata",
        "-cm",
        type=str,
        choices=["upper", "lower", "title", "sentence"],
        help="case for metadata such as author name, email, and subject (overrides config and environment variables)",
    )
    parser.add_argument(
        "--file-append-date",
        "-fad",
        action="store_true",
        help="flag to append date to notes file name (default behavior if no name provided; overrides config and environment variables)",
    )
    parser.add_argument(
        "--file-no-date",
        "-fnd",
        action="store_true",
        help="flag to not append date to notes file (overrides config and environment variables)",
    )
    return parser.parse_args()


def extract_template_metadata(env_settings: dict[str, str | Path | list[str]], config_settings: dict[str, str | Path | list[str]], arg_settings: Namespace) -> tuple[dict[str, str], dict[str, str | Path]]:
    merged = Settings(**{**env_settings, **config_settings, **DEFAULT_TEMPLATE_ARGS.__dict__})
    if arg_settings.directory:
        merged.REPO_DIRECTORY = pseudopath(arg_settings.directory, default_home=False, directory_only=True)
    if arg_settings.sections:
        merged.SECTIONS = arg_settings.sections
    if arg_settings.file_append_date:
        merged.FILE_APPEND_DATE = True
    if arg_settings.file_no_date:
        merged.FILE_APPEND_DATE = False
    if arg_settings.author:
        merged.AUTHOR_NAME = arg_settings.author
    if arg_settings.email:
        merged.AUTHOR_EMAIL = arg_settings.email
    for k, v in  {
        "SECTION_CASING": arg_settings.case_sections or merged.SECTION_CASING,
        "TEMPLATE_CASING": arg_settings.case_template or merged.TEMPLATE_CASING,
        "METADATA_CASING": arg_settings.case_metadata or merged.METADATA_CASING
    }.items():
        if isinstance(v, str) and v.lower() in ("upper", "lower", "title", "sentence"):
            setattr(merged, k, v.lower())
    template = TEMPLATES.get(arg_settings.template, TEMPLATES["default"])
    now_dt = dt.now().strftime(merged.DATE_FORMAT or "%Y-%m-%d")
    templ_vals = {
        "TITLE": arg_settings.title or arg_settings.name or merged.DEFAULT_TITLE or "notes",
        "SUBJECT": arg_settings.subject or "",
        "AUTHOR_NAME": merged.AUTHOR_NAME,
        "AUTHOR_EMAIL": merged.AUTHOR_EMAIL,
        "CREATION_DATE": dt.now().strftime(now_dt),
        "REVISION_DATE": dt.now().strftime(now_dt),
        "SECTIONS": "\n".join([f"{template["section_prefix"]} {s}\n" for s in merged.SECTIONS]) if merged.SECTIONS else "\n",
    }
    file_vals = {
        "arg_settings": arg_settings,
        "directory": (merged.REPO_DIRECTORY or Path.cwd()) if not arg_settings.file_path else pseudopath(arg_settings.file_path, default_home=False, directory_only=True),
        "name": arg_settings.name or templ_vals["TITLE"].replace(" ", "_") or merged.NAME_PREFIX or "note",
        "extension": template.get("extension", "md"),
        "append_date": dt.now().strftime(merged.APPEND_DATE_FORMAT or "%Y%m%d-%H%M%S"),
        "template": template["template"],
    }
    if temp_casing := merged.TEMPLATE_CASING:
        if temp_casing.lower() == "upper":
            for k in templ_vals:
                templ_vals[k] = templ_vals[k].upper()
        elif temp_casing.lower() == "title":
            for k in templ_vals:
                templ_vals[k] = templ_vals[k].title()
        elif temp_casing.lower() == "lower":
            for k in templ_vals:
                templ_vals[k] = templ_vals[k].lower()
        elif temp_casing.lower() == "sentence":
            for k in templ_vals:
                templ_vals[k] = templ_vals[k].capitalize()
    if section_casing := merged.SECTION_CASING:
        if section_casing.lower() == "upper":
            templ_vals["TITLE"] = templ_vals["TITLE"].upper()
            templ_vals["SECTIONS"] = templ_vals["SECTIONS"].upper()
        elif section_casing.lower() == "title":
            templ_vals["TITLE"] = templ_vals["TITLE"].title()
            templ_vals["SECTIONS"] = templ_vals["SECTIONS"].title()
        elif section_casing.lower() == "lower":
            templ_vals["TITLE"] = templ_vals["TITLE"].lower()
            templ_vals["SECTIONS"] = templ_vals["SECTIONS"].lower()
        elif section_casing.lower() == "sentence":
            templ_vals["TITLE"] = templ_vals["TITLE"].capitalize()
            templ_vals["SECTIONS"] = templ_vals["SECTIONS"].capitalize()
    return templ_vals, file_vals


def main():
    env_settings = get_env_settings()
    config_settings = get_config_settings(check_dirs=[env_settings.get("REPO_DIRECTORY")])
    arg_settings = get_arguments()
    templ_vals, file_vals = extract_template_metadata(env_settings, config_settings, arg_settings)
    note = templ_vals["template"].format(**templ_vals)


    file_vals = {
        "directory": (merged.REPO_DIRECTORY or Path.cwd()) if not arg_settings.file_path else pseudopath(arg_settings.file_path, default_home=False, directory_only=True),
        "file_path": arg_settings.file_path,
        "name": arg_settings.name or merged.NAME_PREFIX or "note",
        "extension": template.get("extension", "md"),
        "append_date": dt.now().strftime(merged.APPEND_DATE_FORMAT or "%Y%m%d-%H%M%S"),
        "template": template["template"],
    }
