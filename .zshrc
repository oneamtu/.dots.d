# antigen
source $HOME/.antigen/antigen.zsh
antigen init $HOME/.antigenrc

if [ -f $HOME/.profile ]; then source $HOME/.profile; fi

COMPLETION_WAITING_DOTS="true"
BUNDLED_COMMANDS=(rubocop)

# bash completions compatibility
autoload bashcompinit
bashcompinit

# pandoc completions
if command -v pandoc >/dev/null 2>&1 ; then
  eval "$(pandoc --bash-completion)"
fi

autoload -U zmv

# stop it from annoying autocorrects
unsetopt correct_all

bindkey 'ww' vi-cmd-mode
bindkey 'jj' vi-cmd-mode
bindkey 'jk' vi-cmd-mode
bindkey 'kk' vi-cmd-mode
bindkey 'kj' vi-cmd-mode

# navigation shortcuts
bindkey '^j' undefined-key
bindkey '^k' undefined-key
bindkey '^l' undefined-key
bindkey '^h' undefined-key

bindkey '^r' history-incremental-search-backward

alias git-clean="git branch --merged master | grep -v '\* master' | xargs -n 1 git branch -d"

alias todo="vim ~/todo.txt"
alias org="vim ~/work.org"
alias wifi-rescan="sudo iwlist wlan0 scan"

alias j="jump"

export LOCAL_GEMS_DIR=~/

# better titles
if [ -f '$HOME/opt/google-cloud-sdk/path.zsh.inc' ]; then source '$HOME/.tmux/plugins/tmux-zsh-vim-titles/unified-titles.plugin.zsh'; fi

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

alias wisecow='cowsay $(quote)'
alias fix-wifi='sudo rm -f /etc/resolv.conf && sudo ln -sr /var/run/resolvconf/resolv.conf /etc/'
alias journal='vi ~/ownCloud/todo/journal.org'
alias zshrc-reload='source ~/.zshrc'
alias open='xdg-open &> /dev/null'

if [ -f "~/.dots.d/.zshrc.private" ]; then
  source ~/.dots.d/.zshrc.private
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '$HOME/opt/google-cloud-sdk/path.zsh.inc' ]; then . '$HOME/opt/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '$HOME/opt/google-cloud-sdk/completion.zsh.inc' ]; then . '$HOME/opt/google-cloud-sdk/completion.zsh.inc'; fi

# Make venv prompt work w/ direnv
setopt PROMPT_SUBST

show_virtual_env() {
  if [[ -n "$VIRTUAL_ENV" && -n "$DIRENV_DIR" ]]; then
    echo "($(basename $VIRTUAL_ENV))"
  fi
}
PS1='$(show_virtual_env)'$PS1
