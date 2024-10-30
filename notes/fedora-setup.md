prep
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

export -f _linkr
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

fedora-stuff
```bash
sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm && sync
sudo dnf install -y https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && sync
sudo dnf install -y fedora-workstation-repositories
sudo dnf install -y git gcc glibc-devel cmake gdb nodejs python3.13 neovim fzf fish golang stow gh wget libxcb openssl-devel libX11-devel fuse-libs glibc
```

nvidia-stuff
```bash
sudo dnf install kernel-devel akmod-nvidia xorg-x11-drv-nvidia-cuda xorg-x11-drv-nvidia-cuda-libs vulkan vdpauinfo libva-vdpau-driver libva-utils -y && sync && sudo akmods --force && sync
# sudo dracut --force
# sudo grubby --update-kernel=ALL --args='nvidia-drm.modeset=1';

sudo systemctl enable nvidia-hibernate.service nvidia-suspend.service nvidia-resume.service nvidia-powerd.service
```
git
```bash
git config --global user.email "stephenson.shane.a@gmail.com"
git config --global user.name "Shane Stephenson"
git config --global credential.helper store
gh auth login

git clone https://github.com/oatish/cfg.git $HOME/.config/.cfg

cd $HOME/.config/.cfg
stow .
```

fonts
```bash
_env FONTSTALLER $HOME/tools/fontstaller # te he get it?  FONT iNSTALLER?  ok i'll shut up now
git clone https://github.com/LionyxML/nerd-installer.git $FONTSTALLER
sh $FONSTALLER/nerd-installer.sh

sudo dnf copr enable -y elxreno/jetbrains-mono-fonts
sudo dnf install -y jetbrains-mono-fonts
```

rust
```bash
curl https://sh.rustup.rs -sSf | sh -s -- -y
source "$HOME/.cargo/env"
_path $HOME/.cargo/bin

rustup component add rust-src
rustup component add rust-analyzer
```

cargo-apps
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
cargo install yazi
cargo install choose
cargo install tealdeer
cargo install --locked yazi-fm yazi-cli
cargo install onefetch --force
cargo install coreutils
cargo install fselect
```

homebrew
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

homebrew-apps
```bash
brew install pypy3
brew tap wez/wezterm-linuxbrew
brew install wezterm
brew install podman
```

scripts
```bash
_path $HOME/.scripts/bin
_lnkr $HOME/.config/scripts $HOME/.scripts/bin
sh $HOME/.config/python-venvs/setup.sh
```

keyboard-ish
```bash
sudo dnf copr enable -y alternateved/keyd
sudo dnf install -y keyd

mkdir /etc/keyd
touch /etc/keyd/default.conf
cat > /etc/keyd/default.conf <<EOL
[ids]
*

[main]
capslock = overload(control, esc)

[alt]
h = left
l = right
j = down
k = up
EOL

systemctl enable keyd && systemctl start keyd
```

chrome
```bash
sudo dnf config-manager --set-enabled google-chrome -y
sudo dnf install -y google-chrome-stable

sudo dnf copr enable -y sneexy/zen-browser
sudo dnf install -y zen-browser
_path BROWSER $(which zen-browser)
```

neovim
```bash
_env NVIM_CONFIGS $HOME/.config/nvim
_env EDITOR $(which nvim)
_lnkr $HOME/.config/nvim $HOME/.config/nvim

python3 -m venv $NVIM_CONFIGS/.venv
source $NVIM_CONFIGS/.venv/bin/activate
python3 install -r $NVIM_CONFIGS/requirements.txt
deactivate
npm i -g pyright
```

starship
```bash
curl -sS https://starship.rs/install.sh | sh
ln -s $HOME/.config/starship-prompts/starship.toml $HOME/.config/starship.toml
```

go
```bash
_env GOPATH $HOME/go
_path $HOME/go/bin
```

fish
```bash
# _lnkr $HOME/.config/fish $HOME/.config/fish
```

wezterm
```bash
# wezterm
# sudo dnf copr enable -y wezfurlong/wezterm-nightly
# sudo dnf install -y wezterm
# 
# _lnkr $HOME/.config/wezterm $HOME/.config/wezterm
# _lnkr $HOME/wezterm.lua
_env SHELL $(which wezterm)
```

pipx-apps
```bash
python3.13 -m pip install pipx
pipx install ruff
pipx install dunk
pipx install poetry
pipx install pybuilder
```

kitty
```bash
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
_path $HOME/.local/kitty.app/bin
```

discord
```bash
sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y discord
```

flatpak
```bash
sudo dnf install -y flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

snap
```bash
sudo dnf install snapd
```

magic/modular/mojo/whatever they're calling themselves now lmao
```bash
curl -ssL https://magic.modular.com/de88df84-ddf8-4305-bd78-3195ebbc1314 | bash
```
