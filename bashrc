# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# local "extensions" that shouldn't be kept on github
# ..pre.. getst  sourced in the beginning, -..post.. at the end
[ -e ~/.bashrc.pre.local ] && source ~/.bashrc.pre.local

## functions {{{1
coinflip () {
    # if $1 and $2 are not set, set them with defaults
    # set all other positional parameters as they are provided
    set -- "${1:-heads}" "${2:-tails}" "${@:3}"
    # evaluate the arithmetic expression, which returns a number and
    # echo that positional parameter
    # $RANDOM modulo $# returns a random value from 0 to $#-1
    # pretty equally distributed
    # to test distribution:
    # for i in {1..10000}; do echo $(( RANDOM % 7 )); done | sort -n | uniq -c
    # so add 1 to correpond to the positional parameters
    eval echo \$$(( 1 + RANDOM % $# ))
}

expand_path () {
    # usage: expand_path path [[after]|before]
    _before=""
    _after=""
    # if given with / at the end, delete it
    _dir=${1%/}
    if [[ -n "${2}" && ${2} = "before" ]]; then
        _before="${_dir}:"
    else
        _after=":${_dir}"
    fi
    if [[ -d $_dir ]]; then
        if [[ ${PATH} =~ (:|^)${_dir}(:|$) ]]; then
            :
        else
            export PATH="${_before}${PATH}${_after}"
        fi
    fi
}

find_vim_swaps () {
    find ~/ -name '*.sw[mnop]' -ls
}
## /functions }}}1

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

if [ "$COLORTERM" = "gnome-terminal" ] && [ -z "${TMUX}" ] && [ -z "${PTY}" ]
then
    export TERM=xterm-256color
fi

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# turn globbing on
shopt -s extglob

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=200000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

_VIM=$(type -p vim)
[ -x "${_VIM}" ] && export EDITOR="${_VIM}"

# set PATH so it includes user's private bin if it exists
expand_path "${HOME}/bin" before
expand_path "${HOME}/.local/bin" before

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
# prompt {{{1
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
    xterm-256color) color_prompt=yes;;
    screen-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

## settings for git prompt __git_ps1 {{{2
export GIT_PS1_SHOWDIRTYSTATE="yes"
export GIT_PS1_SHOWUNTRACKEDFILES="yes"
export GIT_PS1_SHOWCOLORHINTS="yes"
export GIT_PS1_SHOWSTASHSTATE="yes"
export GIT_PS1_SHOWUPSTREAM="auto"
## /settings for git prompt __git_ps1 }}}2


# prompt_functions (https://github.com/rathier/spielereien.git) {{{2
prompt_ubuntu_color() {
    unset PROMPT_COMMAND
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
}

prompt_ubuntu_default() {
    unset PROMPT_COMMAND
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
}

prompt_normal() {
    PROMPT_COMMAND='RES=$?; [[ ${RES} -ne 0 ]] && RES_PROMPT="\[\033[0;31m\][${RES}]\[\033[0m\]" || RES_PROMPT=""; history -a; PS1="${RES_PROMPT}[\A][\!][\u@\h] \w $(__git_ps1 "(%s) ")\$ "'
}

prompt_minimal() {
    unset PROMPT_COMMAND
    PS1='\$ '
}

prompt_utf8(){
    PROMPT_COMMAND='RES=$?; [[ ${RES} -ne 0 ]] && RES_PROMPT="\[\033[0;31m\]✗\[\033[0m\] (${RES})" || RES_PROMPT="\[\033[0;32m\]✓\[\033[0m\]"; history -a; PS1="[${RES_PROMPT}][\A][\!][\u@\h] \w $(__git_ps1 "(%s) ")\$ "'
}
# /prompt_functions }}}2
#prompt_utf8
prompt_normal
# /prompt }}}1

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# has to be put in an if-clause, otherwise $? would be 1 and opening a new shell would show an error
if [ -e ~/.bashrc.post.local ];then
    source ~/.bashrc.post.local
fi

