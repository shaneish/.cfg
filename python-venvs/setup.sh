python3.13 -m ensurepip
python3.13 -m venv $HOME/.cfg/python-venvs/default
source $HOME/.cfg/python-venvs/default/bin/activate
python -m pip install -r $HOME/.cfg/python-venvs/default-requirements.txt
deactivate

pypy3 -m ensurepip
pypy3 -m venv $HOME/.cfg/python-venvs/fast
source $HOME/.cfg/python-venvs/fast/bin/activate
pypy3 -m pip install -r $HOME/.cfg/python-venvs/default-requirements.txt
deactivate
