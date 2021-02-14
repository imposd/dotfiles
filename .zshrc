export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="af-magic"

TMUX_CONF="$HOME/.tmux.conf"
ZSH_CONF="$HOME/.zshrc"

export CONFIG="$HOME/.config"
export VIMRC="$CONFIG/nvim/init.vim"

plugins=(git)

source $ZSH/oh-my-zsh.sh

alias vim="nvim"
alias cls="clear"
alias lg="lazygit"
alias tt="nvim $TMUX_CONF"
alias zz="nvim $ZSH_CONF"
alias zs=". $ZSH_CONF"
alias dev="cd $HOME/Dev"
alias ks="tmux kill-session -t 0"
alias ala="nvim $CONFIG/alacritty/alacritty.yml"
alias vimrc="nvim $VIMRC"
alias vps="ssh root@$VPSIP"

export GOPATH=$HOME/golang
export GOROOT=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH
export PATH=$PATH:$GOROOT/bin
