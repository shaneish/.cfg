cp init.vim temp_init.vim
sed '/call plug#end/q' ~/.config/nvim/temp_init.vim > ~/.config/nvim/init.vim
nvim -c 'PlugInstall' -c 'qa'
nvim -c 'TSInstall hcl' -c 'qa'
nvim -c 'TSInstall python' -c 'qa'
nvim -c 'TSInstall rust' -c 'qa'
nvim -c 'TSInstall go' -c 'qa'
nvim -c 'TSInstall bash' -c 'qa'
nvim -c 'TSInstall scala' -c 'qa'
mv temp_init.vim init.vim
