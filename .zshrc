# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="geoffgarside"

COMPLETION_WAITING_DOTS="true"

BUNDLED_COMMANDS=(rubocop)

plugins=(jump cp gitfast git-extras web-search rbenv gem bundler capistrano rand-quote nyan tig)

autoload -U zmv

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

# timetrap completions
autoload -U compinit
compinit
fpath=(/home/oneamtu/.rbenv/versions/2.1.6/lib/ruby/gems/2.1.0/gems/timetrap-1.8.14/completions/zsh $fpath)

alias git-clean="git branch --merged master | grep -v '\* master' | xargs -n 1 git branch -d"

alias todo="vim ~/todo.txt"
alias org="vim ~/org/work.org"
alias wifi-rescan="sudo iwlist wlan0 scan"

alias j="jump"

export LOCAL_GEMS_DIR=~/
export EDITOR=vim

# export TERM="xterm-16color"

export PATH="/home/oneamtu/opt/bin:/home/oneamtu/opt/node/bin:/home/oneamtu/opt/bin:$PATH"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

alias wisecow='cowsay $(quote)'
alias fix-wifi='sudo rm -f /etc/resolv.conf && sudo ln -sr /var/run/resolvconf/resolv.conf /etc/'
alias journal='vi ~/ownCloud/todo/journal.org'
alias bump-fms-config='bundle update --source fms_config && git ci -am "Bump fms_config."'
alias bump-ak-rails-safe-defaults='bundle update --source ak_rails_safe_defaults && git ci -am "Bump ak_rails_safe_defaults."'
alias zshrc-reload='source ~/.zshrc'
alias open='xdg-open &> /dev/null'

source ~/.dots.d/.zshrc.private

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
