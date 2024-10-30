python3.13 -m pip install pipx

python3.13 -m ensurepipe
python3.13 -m venv $HOME/.cfg/default
python3.13 -m pip install -r $HOME/.cfg/default/bin/python

pypy3 -m ensurepipe
pypy3 -m venv $HOME/.cfg/fast
pypy3 -m pip install -r $HOME/.cfg/fast/bin/python
