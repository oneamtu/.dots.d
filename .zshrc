# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Antigen plugin manager
source $HOME/.antigen/antigen.zsh
antigen use oh-my-zsh

antigen bundles <<EOBUNDLES
  asdf
  direnv
  fzf
  gitfast
  ripgrep
  tmux
  vi-mode

  zsh-users/zsh-syntax-highlighting
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-completions
EOBUNDLES

antigen theme romkatv/powerlevel10k
antigen apply

# Shell options
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"
REPORTTIME=3
unsetopt correct_all

# History settings
HISTSIZE=50000
SAVEHIST=50000
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt SHARE_HISTORY

# Prompt customization
setopt PROMPT_SUBST

preexec() {
  __CMD_START_TIME=$SECONDS
}

precmd() {
  if [[ -n $__CMD_START_TIME ]]; then
    local elapsed=$(($SECONDS - $__CMD_START_TIME))
    if (( elapsed > 0 )); then
      print -P "%F{yellow}⏱  ${elapsed}s%f"
    fi
    unset __CMD_START_TIME
  fi
  RPS1="%F{242}[%D{%Y-%m-%d %H:%M:%S}]%f"
}

# Completions
autoload -U compinit && compinit
autoload -U bashcompinit && bashcompinit
autoload -U zmv

if command -v pandoc >/dev/null 2>&1; then
  eval "$(pandoc --bash-completion)"
fi

# Key bindings
bindkey 'jj' vi-cmd-mode
bindkey 'kk' vi-cmd-mode
bindkey '^r' history-incremental-search-backward

# Environment
export EDITOR=vim
export PATH="$HOME/opt/bin:$HOME/.local/bin:$PATH"

# Aliases
alias git-clean="git branch --merged master | grep -v '\* master' | xargs -n 1 git branch -d"
alias zshrc-reload='source ~/.zshrc'
alias open='xdg-open &>/dev/null'
alias todo='vim ~/todo.txt'
alias org='vim ~/work.org'
alias journal='vi ~/ownCloud/todo/journal.org'

# Functions
kubessh() {
  local kube=$(kubectl get pods --namespace="$1" | ruby -ne "puts \$& if /$2[\w-]+app-deployment[\w-]+/")
  echo "Connecting to $kube"
  kubectl exec -it "$kube" --namespace="$1" -- /bin/bash
}


# Google Cloud SDK
if [[ -f "$HOME/opt/google-cloud-sdk/path.zsh.inc" ]]; then
  source "$HOME/opt/google-cloud-sdk/path.zsh.inc"
fi
if [[ -f "$HOME/opt/google-cloud-sdk/completion.zsh.inc" ]]; then
  source "$HOME/opt/google-cloud-sdk/completion.zsh.inc"
fi

alias gcp_internal='gcloud container clusters get-credentials internal-cluster --project=internal-234516 --zone=us-east4-a'
alias gcp_prod='gcloud container clusters get-credentials production --project=production-284017 --zone=us-central1-c'
alias gcp_qc='gcloud container clusters get-credentials qa --project=quality-control-277920 --zone=us-central1-c'

# asdf version manager (handled by antigen plugin)
if [[ -f "$HOME/.asdf/asdf.sh" ]]; then
  source "$HOME/.asdf/asdf.sh"
fi

# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"

# OCaml/opam
[[ -r "$HOME/.opam/opam-init/init.zsh" ]] && source "$HOME/.opam/opam-init/init.zsh" >/dev/null 2>&1

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d "$PYENV_ROOT/bin" ]] && export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init - zsh)"
fi

# Private configurations
[[ -f "$HOME/.zshrc.private" ]] && source "$HOME/.zshrc.private"

# To customize prompt, run `p10k configure` or edit ~/.dots.d/.p10k.zsh.
[[ ! -f ~/.dots.d/.p10k.zsh ]] || source ~/.dots.d/.p10k.zsh
