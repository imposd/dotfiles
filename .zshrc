export ZSH="$HOME/.oh-my-zsh"
export TERM="xterm-256color"

[[ $TMUX != "" ]] && export TERM="screen-256color"

ZSH_THEME="af-magic"

TMUX_CONF="$HOME/.tmux.conf"
ZSH_CONF="$HOME/.zshrc"

export CONFIG="$HOME/.config"
export VIMRC="$CONFIG/nvim/init.vim"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# navigation
alias ..="cd ../"
alias ...="cd ../.."
alias .3="cd ../../../"
alias .4="cd ../../../../"
alias .5="cd ../../../../../"

alias vim="nvim"
alias vi="nvim"
alias cls="clear"
alias lg="lazygit"
alias tt="nvim $TMUX_CONF"
alias zz="nvim $ZSH_CONF"
alias zs=". $ZSH_CONF"
alias dev="cd $HOME/Development"
alias ks="tmux kill-server"
alias ala="nvim $CONFIG/alacritty/alacritty.yml"
alias vimrc="nvim $VIMRC"
#alias cat="bat"
alias rc="nvim $VIMRC"

# pacman and yay
alias unlock="sudo rm /var/lib/pacman/db.lck"
alias cleanup="sudo pacman -Rns $(pacman -Qtdq)"
alias pacman="sudo pacman"

# change ls to exa
#alias ll="exa -al --color=always --group-directories-first"
#alias la="exa -a --color=always --group-directories-first"
#alias ls="exa -l --color=always --group-directories-first"
#alias lt="exa -aT --color=always --group-directories-first"
#alias l.='exa -a | egrep "^\."'

export GOPATH=$HOME/Development/go
export GOROOT=/usr/lib/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH
export PATH=$PATH:$GOROOT/bin

eval "$(starship init zsh)"
