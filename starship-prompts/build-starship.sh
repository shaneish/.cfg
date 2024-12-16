#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cp -f $SCRIPT_DIR/starship.toml $SCRIPT_DIR/backups/starship.toml
cp -f $SCRIPT_DIR/starship-minimal.toml $SCRIPT_DIR/backups/starship-minimal.toml

cat $SCRIPT_DIR/base/starship-base-minimal.toml > $SCRIPT_DIR/starship-minimal.toml
cat $SCRIPT_DIR/base/starship-base.toml >> $SCRIPT_DIR/starship-minimal.toml
cat $SCRIPT_DIR/base/starship-base-right.toml > $SCRIPT_DIR/starship.toml
cat $SCRIPT_DIR/base/starship-base.toml >> $SCRIPT_DIR/starship.toml

cp -f $SCRIPT_DIR/starship.toml "$(dirname $SCRIPT_DIR)"/starship.toml
