export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="alanpeabody"

plugins=(git)

source $ZSH/oh-my-zsh.sh

alias vim="nvim"
alias projects="cd /mnt/d/Projects"
alias pebblo="cd /mnt/d/Projects/Pebblo"
alias api="pebblo && cd /API/core"
alias py="python3"
alias cls="clear"
alias pp="cd $HOME/python"
alias lg="lazygit"

export GOROOT="/usr/local/go"
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$GOROOT/bin:$PATH"
