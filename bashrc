# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# local "extensions" that shouldn't be kept on github
# ..pre.. getst  sourced in the beginning, -..post.. at the end
[ -e ~/.bashrc.pre.local ] && source ~/.bashrc.pre.local

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

if [ "$COLORTERM" = "gnome-terminal" ]
then
    export TERM=screen-256color
fi

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# turn globbing on
shopt -s extglob

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

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
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    # show returncode of last command if it is not zero, colored in red
    PROMPT_COMMAND='RES=$?; [[ ${RES} -ne 0 ]] && RES_PROMPT="\[\033[0;31m\][${RES}]\[\033[0m\]" || RES_PROMPT=""; history -a; PS1="${RES_PROMPT}[\A][\!][\u@\h] \w \$ "'
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# some examples and explanations
#PROMPT_COMMAND='RES=$?; [[ ${RES} -eq 0 ]] && RCCOL=34 || RCCOL=31 ; history -a ; PS1="\[\033[0;${RCCOL}m\][${RES}]\[\033[0m\] [\A][\!][\u@\h] \w \$ "'
# examples: set a fancy prompt
#    PS1='\u@\h:\w\$ '
#    PS1="[\033[00;34m\]\u\033[0m\]@\033[01;34m\]\h\033[0m\]:\w]\$ "
#    PS1='[\033[00;34m\u\033[m@\033[1;34m\h\033[m:\w]\$ '

## from bash-manpage:
#   \a     an ASCII bell character (07)
#   \d     the date in "Weekday Month Date" format (e.g., "Tue May 26")
#   \D{format}
#          the  format  is  passed  to  strftime(3)  and the result is inserted into the prompt string; an empty format
#          results in a locale-specific time representation.  The braces are required
#   \e     an ASCII escape character (033)
#   \h     the hostname up to the first `.'
#   \H     the hostname
#   \j     the number of jobs currently managed by the shell
#   \l     the basename of the shell's terminal device name
#   \n     newline
#   \r     carriage return
#   \s     the name of the shell, the basename of $0 (the portion following the final slash)
#   \t     the current time in 24-hour HH:MM:SS format
#   \T     the current time in 12-hour HH:MM:SS format
#   \@     the current time in 12-hour am/pm format
#   \A     the current time in 24-hour HH:MM format
#   \u     the username of the current user
#   \v     the version of bash (e.g., 2.00)
#   \V     the release of bash, version + patch level (e.g., 2.00.0)
#   \w     the current working directory, with $HOME abbreviated with a tilde
#   \W     the basename of the current working directory, with $HOME abbreviated with a tilde
#   \!     the history number of this command
#   \#     the command number of this command
#   \$     if the effective UID is 0, a #, otherwise a $
#   \nnn   the character corresponding to the octal number nnn
#   \\     a backslash
#   \[     begin a sequence of non-printing characters, which could be used to embed a terminal control  sequence  into
#          the prompt
#   \]     end a sequence of non-printing characters
#

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

[ -e ~/.bashrc.post.local ] && source ~/.bashrc.post.local

