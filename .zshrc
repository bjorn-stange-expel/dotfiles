# zmodload zsh/zprof

# Path to your oh-my-zsh configuration.
#if [ "$TMUX" = "" ];
#    then tmux;
#else
#    tmux attach -t $TMUX;
#fi
#

#TMUX for remote servers
#if [ "$PS1" != "" -a "${STARTED_TMUX:-x}" = x -a "${SSH_TTY:-x}" != x ]
#then
#        STARTED_TMUX=1; export STARTED_TMUX
#        sleep 1
#        ( (tmux has-session -t remote && tmux attach-session -t remote) || (tmux new-session -s remote) ) && exit 0
#        echo "tmux failed to start"
#fi

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
# Let's see if it's really a drop-in replacement
# alias docker='podman'

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git kubectl docker)

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

# krew
PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

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
  PS1="$($GOPATH/bin/powerline-go -theme ~/.config/powerline-go/themes/custom.json -modules kube,cwd,git,exit -error $? -jobs ${${(%):%j}:-0})"

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

if [ "$TERM" != "linux" ] && [ -f "$GOPATH/bin/powerline-go" ]; then
  install_powerline_precmd
fi
# Firstname Lastname
export FIRSTNAME='bjorn'
export LASTNAME='stange'

# Expel config
source /Users/bjornstange/.config/.expelrc


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/bjornstange/.google-cloud-sdk/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/bjornstange/.google-cloud-sdk/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/bjornstange/.google-cloud-sdk/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/bjornstange/.google-cloud-sdk/google-cloud-sdk/completion.zsh.inc'; fi

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
export EDITOR=/usr/local/bin/nvim

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export VAULT_TEAM=eng-cep

source ~/expel/workbench_token_grabber/get_workbench_token.sh

export USE_GKE_GCLOUD_AUTH_PLUGIN=True

export HOMEBREW_NO_AUTO_UPDATE=1
