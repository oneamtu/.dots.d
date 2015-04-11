# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="geoffgarside"

COMPLETION_WAITING_DOTS="true"

plugins=(jump tmux cp gitfast git-extras web-search rbenv gem bundler capistrano zeus rand-quote nyan)

source $ZSH/oh-my-zsh.sh

# stop it from annoying autocorrects
unsetopt correct_all

bindkey 'jj' vi-cmd-mode
bindkey 'kk' vi-cmd-mode

# navigation shortcuts
bindkey '^j' undefined-key
bindkey '^k' undefined-key
bindkey '^l' undefined-key
bindkey '^h' undefined-key

bindkey '^r' history-incremental-search-backward

alias git-clean="git branch --merged master | grep -v '\* master' | xargs -n 1 git branch -d"

alias todo="vim ~/todo.txt"

export LOCAL_GEMS_DIR=~/
export EDITOR=vim

export RAILS_MYSQL_USER=rails
export RAILS_MYSQL_PASSWORD=railspw
