# rust
curl https://sh.rustup.rs -sSf | sh -s -- -y
source "$HOME/.cargo/env"
_empa $HOME/.cargo/bin

rustup component add rust-src
rustup component add rust-analyzer