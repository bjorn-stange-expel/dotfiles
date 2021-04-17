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
ZSH_THEME="agnoster"

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
PATH=$HOME/go/bin:$PATH # Add Go bin
PATH=/opt/chefdk/bin:$PATH # Add ChefDK
PATH=$PATH:/Users/bstange/.chefdk/gem/ruby/2.4.0/bin # Add ChefDK Ruby Gems
PATH=$PATH:/usr/local/sbin # Add /usr/local/sbin
PATH=$PATH:/Users/bstange/.nodejs/bin # Add local nodejs bin
PATH=$PATH:/Users/bstange/Library/Python/3.9/bin # Add user Python bin
PATH=$PATH:/Users/bstange/go/bin # Add Go bin
PATH=/usr/local/opt/openssl/bin:$PATH # Add openssl bin

# Android Paths
PATH=$PATH:/Users/bstange/Library/Android/sdk/platform-tools
PATH=$PATH:/Users/bstange/Library/Android/sdk/cmdline-tools/latest/bin
PATH=$PATH:/Users/bstange/Library/Android/sdk/emulator

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

PATH="/Users/bstange/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/bstange/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/bstange/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/bstange/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/bstange/perl5"; export PERL_MM_OPT;
