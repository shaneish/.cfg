### prep
```bash
# prep
export ENV_PATH=$HOME/.env
export PATH_PATH=$HOME/.path
export ALIAS_PATH=$HOME/.alias

_path() {
  export PATH="$PATH:$1"
  echo "$1" >> $PATH_PATH
  if [ ! -e "$1" ]; then
    mkdir -p $1
  fi
}

_env() {
  export $1="$2"
  echo "$1=\"$2\"" >> $ENV_PATH
  if [ ! -e "$1" ]; then
    mkdir -p $1
  fi
}

_rm() {
  if [ -e "$1" ]; then
    if type -P rip >/dev/null 2>&1; then
      rip $1
    else
      rm $1
    fi
  fi
}

_alias() {
  alias $1="$2"
  echo "alias $1=\"$2\"" >> $ALIAS_PATH
}

_lnkr() { # Link - Rip (also, like LINKER)
  _rm $2
  ln -rs $1 $2
}

export -f _lnkr
export -f _alias
export -f _rm
export -f _env
export -f _path

_env CONFIG_PATH $HOME/.config
_env CONFIGS $HOME/.config
_env CFG_PATH $HOME/.config/.cfg # ya lazy naming i know
_env CFG $HOME/.config/.cfg
_path $HOME/.local/bin
_path $HOME/dev
_path $HOME/sys
_path $HOME/Projects
_path $HOME/System
_path $HOME/tools
_path /usr/local/bin
```

### base
```bash
sudo pacman -S stow # gotta call stow before all the apps are installed nahmsayin??
git clone https://github.com/shaneish/.cfg.git $HOME/.config/.cfg
cd $HOME/.config/.cfg
stow .

sudo pacman -S ttf-jetbrains-mono ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols-mono github-cli cmake keyd fish wezterm pypy3 go neofetch kitty waybar discord spotify-launcher nodejs npm base-devel zig jq hyprland waybar wofi hyprpaper
yay -S neovim-git
yay -S zen-browser-avx2-bin
yay -S google-chrome
yay -S python313
yay -S swayfx
yay -S hyprshot
```

### pipx-apps
```bash
python3.13 -m ensurepip
python3.13 -m pip install pipx
pipx install ruff
pipx install dunk
pipx install poetry
pipx install pybuilder
pipx install git+https://github.com/shaneish/fnkpy.git
```

### git
```bash
git config --global user.email "stephenson.shane.a@gmail.com"
git config --global user.name "Shane Stephenson"
git config --global credential.helper store
gh auth login

git clone https://github.com/shaneish/.cfg.git $HOME/.config/.cfg

cd $HOME/.config/.cfg
stow .
```

### rust
```bash
curl https://sh.rustup.rs -sSf | sh -s -- -y
source "$HOME/.cargo/env"
_path $HOME/.cargo/bin

rustup component add rust-src
rustup component add rust-analyzer
rustup component add clippy
rustup component add rustfmt
rustup component add rust-docs
rustup component add llvm-tools
```

### cargo-apps
```bash
cargo install ripgrep
cargo install sd
cargo install rm-improved
cargo install eza
cargo install lsd
cargo install --locked bat
cargo install skim
cargo install fd-find
cargo install bhop
cargo install nu
cargo install ouch
cargo install procs
cargo install rargs
cargo isntall xh
cargo install grex
cargo install choose
cargo install tealdeer
cargo install --locked yazi-fm yazi-cli
cargo install onefetch --force
cargo install coreutils
cargo install fselect
cargo install starship
cargo install xsv
cargo install --locked jaq
cargo install toml-cli
```

### scripts
```bash
_path $HOME/.scripts/bin
_lnkr $HOME/.config/scripts $HOME/.scripts/bin
sh $HOME/.config/python-venvs/setup.sh
```

### keyboard-ish
```bash
mkdir /etc/keyd
touch /etc/keyd/default.conf
cat > /etc/keyd/default.conf <<EOL
[ids]
*

[main]
capslock = overload(control, esc)
esc = capslock

[alt]
h = left
l = right
j = down
k = up
EOL

systemctl enable keyd && systemctl start keyd
```

### neovim
```bash
_env NVIM_CONFIGS $HOME/.config/nvim
_env EDITOR $(which nvim)

cd $NVIM_CONFIGS
python3 -m venv .venv
source .venv/bin/activate
python3 install -r requirements.txt
deactivate
sudo npm i -g pyright
```

### magic/modular/mojo/whatever they're calling themselves now lmao
```bash
curl -ssL https://magic.modular.com/de88df84-ddf8-4305-bd78-3195ebbc1314 | bash
```
