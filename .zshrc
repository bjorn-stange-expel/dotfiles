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
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

PATH=$HOME/bin:$PATH # Add Personal bin
PATH=/opt/chefdk/bin:$PATH # Add ChefDK
# PATH=$PATH:~/.chefdk/gem/ruby/2.4.0/bin # Add ChefDK Ruby Gems
PATH=$PATH:/usr/local/sbin # Add /usr/local/sbin
PATH=$PATH:~/.npm/bin # Add local nodejs bin
PATH=$PATH:/usr/local/go/bin # Add system Go bin
PATH=$PATH:~/go/bin # Add user Go bin
PATH=/usr/local/opt/openssl/bin:$PATH # Add openssl bin

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

source ~/.config/pash/pash.sh

go_test() {
  go test $* | sed ''/PASS/s//$(printf "\033[32mPASS\033[0m")/'' | sed ''/SKIP/s//$(printf "\033[34mSKIP\033[0m")/'' | sed ''/FAIL/s//$(printf "\033[31mFAIL\033[0m")/'' | sed ''/FAIL/s//$(printf "\033[31mFAIL\033[0m")/'' | GREP_COLOR="01;33" egrep --color=always '\s*[a-zA-Z0-9\-_.]+[:][0-9]+[:]|^'
}

function powerline_precmd() {
  PS1="$($GOPATH/bin/powerline-go -theme ~/.config/powerline-go/themes/custom.json -modules cwd,git,kube,exit -error $? -jobs ${${(%):%j}:-0})"

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
