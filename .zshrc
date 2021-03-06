# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="geoffgarside"

COMPLETION_WAITING_DOTS="true"

BUNDLED_COMMANDS=(rubocop)

# bash completions compatibility
autoload bashcompinit
bashcompinit

# pandoc completions
eval "$(pandoc --bash-completion)"

# unified-titles comes from https://github.com/MikeDacre/tmux-zsh-vim-titles
# could be installed via a plugin manager..
source /home/oneamtu/.oh-my-zsh/custom/plugins/tmux-zsh-vim-titles/unified-titles.plugin.zsh

# plugins=(jump cp gitfast git-extras web-search rbenv gem bundler capistrano rand-quote nyan tig asdf)
plugins=(bundler asdf)

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
# autoload -U compinit
# compinit
# fpath=(/home/oneamtu/.rbenv/versions/2.1.6/lib/ruby/gems/2.1.0/gems/timetrap-1.8.14/completions/zsh $fpath)

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

alias pass-copy-gcp="passbolt get $(passbolt find | awk '/GCP/ { print $NF }')  | gpg -q --no-tty | xsel -b -i"

function kubessh() {
  kube=$(kubectl get pods --namespace=$1 | ruby -ne "puts $& if /$2[\w-]+app-deployment[\w-]+/")
  print "Connecting to $kube"
  kubectl exec -it $kube --namespace=$1 -- /bin/bash
}

source ~/.dots.d/.zshrc.private

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

#direnv hook
eval "$(direnv hook zsh)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/oneamtu/opt/google-cloud-sdk/path.zsh.inc' ]; then . '/home/oneamtu/opt/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/oneamtu/opt/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/oneamtu/opt/google-cloud-sdk/completion.zsh.inc'; fi

alias gcp_internal='gcloud container clusters get-credentials internal-cluster --project=internal-234516 --zone=us-east4-a'
alias gcp_prod='gcloud container clusters get-credentials production --project=production-284017 --zone=us-central1-c'
alias gcp_qc='gcloud container clusters get-credentials qa --project=quality-control-277920 --zone=us-central1-c'
