# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

## functions {{{1
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
## end functions }}}1

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
expand_path "${HOME}/bin" before
expand_path "${HOME}/.local/bin" before
