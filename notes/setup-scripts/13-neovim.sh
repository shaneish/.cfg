# neovim
sudo dnf install -y neovim
_empa NVIM_CONFIGS $CONFIGS/nvim
_empa EDITOR $(which nvim)
_lnkr $CFG/nvim $CONFIGS/nvim

python3 -m venv $NVIM_CONFIGS/.venv
source $NVIM_CONFIGS/.venv/bin/activate
python3 install -r $NVIM_CONFIGS/requirements.txt
deactivate
npm i -g pyright