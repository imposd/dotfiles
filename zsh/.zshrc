export ZSH="$HOME/.oh-my-zsh"
export TERM="xterm-256color"

[[ $TMUX != "" ]] && export TERM="screen-256color"

ZSH_THEME="af-magic"

TMUX_CONF="$HOME/tmux/.tmux.conf"
ZSH_CONF="$HOME/zsh/.zshrc"

export CONFIG="$HOME/.config"
export VIMRC="$CONFIG/nvim/init.vim"
export EDITOR="nvim"
export GIT_EDITOR="nvim"

plugins=(
  git
  systemadmin
)

source $ZSH/oh-my-zsh.sh

ix() {
    local opts
    local OPTIND
    [ -f "$HOME/.netrc" ] && opts='-n'
    while getopts ":hd:i:n:" x; do
        case $x in
            h) echo "ix [-d ID] [-i ID] [-n N] [opts]"; return;;
            d) $echo curl $opts -X DELETE ix.io/$OPTARG; return;;
            i) opts="$opts -X PUT"; local id="$OPTARG";;
            n) opts="$opts -F read:1=$OPTARG";;
        esac
    done
    shift $(($OPTIND - 1))
    [ -t 0 ] && {
        local filename="$1"
        shift
        [ "$filename" ] && {
            curl $opts -F f:1=@"$filename" $* ix.io/$id
            return
        }
        echo "^C to cancel, ^D to send."
    }
    curl $opts -F f:1='<-' $* ix.io/$id
}

haste () {
	local output returnfile contents
  if (( $# == 0 )) && [[ $(printf "%s" "$0" | wc -c) > 0 ]]
    then
    contents=$0
  elif (( $# != 1 )) || [[ $1 =~ ^(-h|--help)$ ]]
    then
    echo "Usage: $0 FILE"
    echo "Upload contents of plaintext document to hst.sh."
    echo "Invocation with no arguments takes input from stdin or pipe."
    echo "Terminate stdin by EOF (Ctrl-D)."
    return 1
  elif [[ -e $1 && ! -f $1 ]]
    then
    echo "Error: Not a regular file."
    return 1
  elif [[ ! -e $1 ]]
  then
    echo "Error: No such file."
    return 1
  elif (( $(stat -c %s $1) > (512*1024**1) ))
    then
    echo "Error: File must be smaller than 512 KiB."
    return 1
  fi
  if [[ -n "$contents" ]] || [[ $(printf "%s" "$contents" | wc -c) < 1 ]]
    then
    contents=$(cat $1)
  fi
  output=$(curl -s -f -X POST "https://hst.sh/documents" -d "$contents")
  if (( $? == 0 )) && [[ $output =~ \"key\" ]]
    then
    returnfile=$(sed 's/^.*"key":"/https:\/\/hst.sh\//;s/".*$//' <<< "$output")
    if [[ -n $returnfile ]]
      then
      echo "$returnfile"
      return 0
    fi
  fi
  echo "Upload failed."
  return 1
}

# maybe make one for imperialb.in

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
alias tt="nvim $TMUX_CONF"
alias paste="ix -F"
alias ps="ix -F"
alias hs="haste"
alias sl=sxiv

# pacman and yay
alias unlock="sudo rm /var/lib/pacman/db.lck"
alias cleanup="sudo pacman -Rns $(pacman -Qtdq)"
alias pacman="sudo pacman"

# change ls to exa
alias la="exa -al --color=always --group-directories-first"
alias la="exa -a --color=always --group-directories-first"
alias ls="exa -l --color=always --group-directories-first"
alias lt="exa -aT --color=always --group-directories-first"
alias l.='exa -a | egrep "^\."'

#keyboard
alias asdf="setxkbmap us real-prog-dvorak"
alias aoeu="setxkbmap us"

# git alias
alias ci="git commit"
alias co="git checkout"
alias br="git branch"
alias st="git status"

export GOPATH=$HOME/Development/go
export GOROOT=/usr/lib/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH
export PATH=$PATH:$GOROOT/bin

source ~/.profile
. ~/z.sh
