# prep
export ENV_PATH=$HOME/.env
export PATH_PATH=$HOME/.path
export ALIAS_PATH=$HOME/.alias

_empa() { # Env - Path - Mkdir - Alias
  echo $@
  if [ "$2" = "" ]; then
    if [ ! -e "$1" ]; then
      echo mkdir $1...
      mkdir -p $1
    fi
    if [ -e "$1" ]; then
      echo "$1" >> $PATH_PATH
      export PATH="$PATH:$1"
      echo path :$1...
    fi
  elif [[ "$1" == "${1^^}" ]]; then
    echo alias $1 = $2
    alias $1="$2"
    echo "alias $1=\"$2\"" >> $ALIAS_PATH
  else
    echo export $1 = $2
    export $1="$2"
    echo "export $1=$2" >> $ENV_PATH
  fi
}

_lnkr() { # Link - Rip (also, like LINKER)
  if [ -e "$1"] && [ "$2" == "" ]; then
    rip $1
  elif [ -e "$2" ]; then
    if [ ! "$2" == *"$PATH"* ]; then
      rip $2
    fi
    ln -rs $1 $2
  fi
}

_empa CONFIG_PATH $HOME/.config
_empa CFG_PATH $HOME/.cfg # ya lazy naming i know
_empa $HOME/.local/bin
_empa $HOME/dev
_empa $HOME/sys
_empa $HOME/tools
_empa /usr/local/bin

# dnf install -y fedora-workstation-repositories
# dnf install -y sway-config-fedora
