apt install neovim
apt install nodejs
apt install npm
rustup component add rust-src
mkdir -p ~/.local/bin
rustup component add rust-analyzer
ln -s "$(rustup which rust-analyzer)" ~/.cargo/bin/rust-analyzer
python3 -m venv ~/.config/nvim/venv
. ~/.config/nvim/venv/bin/activate
pip install -r ~/.config/nvim/scripts/requirements.txt
deactivate
npm i -g pyright
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
cp ~/.config/nvim/init.vim temp_init.vim
sed '/call plug#end/q' ~/.config/nvim/temp_init.vim > ~/.config/nvim/init.vim
nvim -c 'PlugInstall' -c 'qa'
nvim -c 'TSInstall hcl' -c 'qa'
nvim -c 'TSInstall python' -c 'qa'
nvim -c 'TSInstall rust' -c 'qa'
nvim -c 'TSInstall go' -c 'qa'
nvim -c 'TSInstall bash' -c 'qa'
nvim -c 'TSInstall scala' -c 'qa'
mv temp_init.vim i~/.config/nvim/nit.vim
