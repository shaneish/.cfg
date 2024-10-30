#!/bin/bash

if [ -z "$CONFIG_DIRECTORY" ]; then
    export CONFIG_DIRECTORY=$HOME/.config
fi
DOTS_DIRECTORY=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
BACKUP_DIRECTORY=$CONFIG_DIRECTORY/backups
OS="$(uname -s)"

alias DEL="rm -r"

if [ ! -d $BACKUP_DIRECTORY ]; then
    mkdir $BACKUP_DIRECTORY
    echo "Created backup directory..."
fi

if ! command -v rip 2>&1 >/dev/null; then
    alias DEL="rip"
fi

_prop() {
    if [ -d $CONFIG_DIRECTORY/$1 ]; then
        let dt_id = $(date '+%Y%m%d-%H%M%S')
        cp -f $CONFIG_DIRECTORY/$1 $BACKUP_DIRECTORY/${1}-$dt_id
        echo "$CONFIG_DIRECTORY/$1 backed up..."
        DEL $CONFIG_DIRECTORY/$1
        echo "$CONFIG_DIRECTORY/$1 removed..."
    fi
    ln -s $DOTS_DIRECTORY/$1 $CONFIG_DIRECTORY/$1
    echo "Symlink from $DOTS_DIRECTORY/$1 -> $CONFIG_DIRECTORY/$1 created..."
}

_cargo() {
    if ! command -v cargo 2>&1 >/dev/null; then
        curl https://sh.rustup.rs -sSf | sh
        echo "Installing Cargo..."
    fi
    if ! command -v $1 2>&1 >/dev/null}; then
        if [ "$2" != "" ]; then
            cargo install "${@:2}"
        else
            cargo install $1
        fi
    fi
}

_pipx() {
    if ! command -v pipx 2>&1 >/dev/null; then
        python3 -m pip install pipx
        echo "Installing pipx..."
    fi
    if ! command -v $1 2>&1 >/dev/null}; then
        pipx install $1
    fi
}

if [ "$@" == *"dots"* ]; then
    _prop nvim
    _prop wezterm
    _prop starship.toml
    _prop yazi
    _prop fish
    _prop bhop

    if [ $OS =~ *"Linux"* ]; then
        _prop hypr
        _prop waybar
        _prop sway
    fi

    if [ $OS =~ *"Darwin"* ]; then
        _prop aerospace.toml
    fi
fi

if [ "$@" == *"apps"* ]; then
    _cargo rg ripgrep
    _cargo eza
    _cargo lsd
    _cargo bat
    _cargo sk skim
    _cargo fd fd-find
    _cargo bhop
    _cargo nu nushell
    _cargo ouch
    _cargo procs
    _cargo rargs
    _cargo xh
    _cargo grex
    _cargo yazi yazi-fm yaza-cli
    _cargo choose
    _cargo onefetch
    _cargo tldr tealdeer
    _cargo btm bottom
    _cargo difft difftastic
    _cargo fselect
    _cargo rip rm-improved
    _cargo pipr

    _pipx ruff
    _pipx dunk
fi
