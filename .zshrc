export PATH=$PATH:$HOME/homebrew/bin

ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="agnoster"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias cl="clear"
alias lsf='ls -d -1 `pwd`/**/*'
alias vim='nvim'
alias baty='bat -l yaml'
alias batj='bat -l json'

alias ls='ls -G'
alias kuberuhroh='kubectl get pods --all-namespaces -owide | grep -vE "Running|Completed|Error|Shutdown"'
plugins=(git kubectl docker)

alias k='kubectl $@'
alias ka='kubectl get --all-namespaces $@'
alias tf='terraform $@'
alias kprod='k --context=gke_expel-engineering-prod_us-east1_prod $@'
alias kstage='k --context=gke_expel-engineering-internal_us-east1_staging $@'

alias tpprod="tsh --proxy=teleport.opsv2.expel.io --user $FIRSTNAME.$LASTNAME --login $FIRSTNAME.$LASTNAME"
alias tpstaging="tsh --proxy=teleport.stagingv2.expel.io --user $FIRSTNAME.$LASTNAME --login $FIRSTNAME.$LASTNAME"

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

export LSCOLORS=Gxfxcxdxbxegedabagacad

PATH=$HOME/expel/cep-tools/bin/bin:$PATH # Add Expel bin
PATH=$HOME/bin:$PATH # Add Personal bin
PATH=/opt/chefdk/bin:$PATH # Add ChefDK
# PATH=$PATH:~/.chefdk/gem/ruby/2.4.0/bin # Add ChefDK Ruby Gems
PATH=$PATH:/usr/local/sbin # Add /usr/local/sbin
PATH=~/.npm/bin:$PATH # Add local nodejs bin
export N_PREFIX=~/.n
PATH=$N_PREFIX/bin:$PATH
PATH=$PATH:/usr/local/go/bin # Add system Go bin
PATH=$PATH:~/go/bin # Add user Go bin
PATH=$HOME/bin/go/bin:$PATH # Add go 1.18 override
PATH=/usr/local/opt/openssl/bin:$PATH # Add openssl bin
# PATH=/usr/local/opt/curl/bin:$PATH # Add curl bin

PATH=/usr/local/sessionmanagerplugin/bin:$PATH # Add openssl bin

# krew
PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# linkerd
export PATH=$HOME/.linkerd2/bin:$PATH


function mkcd() {
  mkdir $1
  cd $1
}

function sha256 () {
  echo -n $1 | openssl dgst -sha256
}

. ~/z/z.sh

export GPG_TTY=$(tty)
export GOPATH=$HOME/go

go_test() {
  go test $* | sed ''/PASS/s//$(printf "\033[32mPASS\033[0m")/'' | sed ''/SKIP/s//$(printf "\033[34mSKIP\033[0m")/'' | sed ''/FAIL/s//$(printf "\033[31mFAIL\033[0m")/'' | sed ''/FAIL/s//$(printf "\033[31mFAIL\033[0m")/'' | GREP_COLOR="01;33" egrep --color=always '\s*[a-zA-Z0-9\-_.]+[:][0-9]+[:]|^'
}

function powerline_precmd() {
  PS1="$($HOME/bin/powerline-go -theme ~/dotfiles/custom.json -modules kube,cwd,git,exit -error $? -jobs ${${(%):%j}:-0})"
  # PS1="$($GOPATH/bin/powerline-go -theme ~/.config/powerline-go/themes/custom.json -modules cwd,git,exit -error $? -jobs ${${(%):%j}:-0})"

    # Uncomment the following line to automatically clear errors after showing
    # them once. This not only clears the error for powerline-go, but also for
      # everything else you run in that shell. Don't enable this if you're not
        # sure this is what you want.

    #set "?"
  }

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ] && [ -f "$HOME/bin/powerline-go" ]; then
  install_powerline_precmd
fi
# Firstname Lastname
export FIRSTNAME='bjorn'
export LASTNAME='stange'

source ~/expel/cep-tools/bash_funcs/source_all

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init --path)"
# eval "$(pyenv init -)"

# goenv
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
# eval "$(goenv init -)"

# set EDITOR to nvim
export EDITOR=$HOME/homebrew/bin/nvim

timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

ksecret() {
    kubectl get secret "$@" -o json | jq -r '.data | to_entries[] | "\(.key): \(.value | @base64d)"'
}

# zstyle ':completion:*' completer _complete
# zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
# autoload -Uz compinit
# compinit

export KUBE_CONFIG_PATH=$HOME/.kube/config

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh OLD fzf import

source <(fzf --zsh)

export VAULT_TEAM=eng-cep

export USE_GKE_GCLOUD_AUTH_PLUGIN=True

export HOMEBREW_NO_AUTO_UPDATE=1
export HISTTIMEFORMAT="%F %T "

# AWS
export PATH="$PATH:$HOME/aws/aws-cli"

export AWS_PAGER=""

export TERM="xterm-256color"

# export HISTSIZE=200000
setopt HIST_IGNORE_SPACE
# export SAVEHIST=100000
# The next line updates PATH for the Google Cloud SDK.
if [ -f "/Users/bjorn/google-cloud-sdk/path.zsh.inc" ]; then . "/Users/bjorn/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "/Users/bjorn/google-cloud-sdk/completion.zsh.inc" ]; then . "/Users/bjorn/google-cloud-sdk/completion.zsh.inc"; fi

export CLOUDSDK_PYTHON=$HOME/homebrew/bin/python3.12
