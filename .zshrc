export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
    git
    dotenv
)

export EDITOR=/usr/bin/vim
alias projects="cd ~/Projects"
alias pebblo="cd ~/Projects/Pebblo"

source $ZSH/oh-my-zsh.sh
