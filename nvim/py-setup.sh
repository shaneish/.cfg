export NVIM_DIR="$HOME/.config/nvim"
python3.12 -m venv $NVIM_DIR/.venv
. $NVIM_DIR/.venv/bin/activate
python -m pip install -r $NVIM_DIR/requirements.txt
echo "{ \"venvPath\": \"$NVIM_DIR\", \"venv\": \".venv\" }" > pyrightconfig.json
