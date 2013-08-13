#
# ~/.bashrc
#

# TMUX for remote servers
if [ "$PS1" != "" -a "${STARTED_TMUX:-x}" = x -a "${SSH_TTY:-x}" != x ]
then
        STARTED_TMUX=1; export STARTED_TMUX
        sleep 1
        ( (tmux has-session -t remote && tmux attach-session -t remote) || (tmux new-session -s remote) ) && exit 0
        echo "tmux failed to start"
fi
alias cl="clear"
alias lsf='ls -d -1 `pwd`/**/*'
alias lsd='du -sh *'
alias ls='ls --color=auto'
alias ll='ls -lash'
alias tmux="TERM=screen-256color-bce tmux"

PS1='[\u@\h \W]\$ '
complete -cf sudo
complete -cf man

function mkcd() {
    mkdir $1;
    cd $1;
}
