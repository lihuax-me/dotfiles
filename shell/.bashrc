#
# ~/.bashrc
#

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export https_proxy=http://127.0.0.1:7897 http_proxy=http://127.0.0.1:7897 all_proxy=socks5://127.0.0.1:7897

# vi mode
set -o vi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

##
## Slightly nicer .bashrc
## Makes pretty colors and stuff
##

## Where to search for manual pages
export MANPATH="/usr/share/man:/usr/local/man:/usr/local/local_dfs/man"

## Which pager to use.
export PAGER=less

## Choose your weapon
EDITOR=/usr/bin/nvim
#EDITOR=/usr/bin/emacs
#EDITOR=/usr/bin/nano
# export GIT_EDITOR="nvr -cc split --remote-wait +'set bufhidden=wipe'"
export GIT_EDITOR="nvim"
export EDITOR

## The maximum number of lines in your history file
export HISTFILESIZE=50

## Enables displaying colors in the terminal
# export TERM=xterm-color

## Disable automatic mail checking
unset MAILCHECK 

## If this is an interactive console, disable messaging
#tty -s && mesg n


## Automatically correct mistyped 'cd' directories
#shopt -s cdspell

## Append to history file; do not overwrite
if [[ $0 == "bash" ]] ; then
  shopt -s histappend
fi

## Prevent accidental overwrites when using IO redirection
# set -o noclobber

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
# HISTCONTROL=ignoreboth
export HISTCONTROL=ignoredups


# append to the history file, don't overwrite it
if [[ -n "$BASH_VERSION" ]]; then
  shopt -s histappend
fi

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
if [[ -n "$BASH_VERSION" ]]; then
  shopt -s checkwinsize
fi

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /opt/bin/lesspipe ] && eval "$(SHELL=/system/bin/sh lesspipe)"

# Using color promt
if [[ -n "$BASH_VERSION" ]]; then
  if [[ ${EUID} == 0 ]] ; then
      PS1='\[\033[48;2;221;75;57;38;2;255;255;255m\] \$ \[\033[48;2;150;75;255;38;2;221;75;57m\]\[\033[48;2;150;75;255;38;2;255;255;255m\] \h \[\033[48;2;83;85;85;38;2;150;75;255m\]\[\033[48;2;83;85;85;38;2;255;255;255m\] \w \[\033[49;38;2;83;85;85m\]\[\033[00m\] '
  else
      PS1='\[\033[48;2;255;105;180;38;2;255;255;255m\] \$ \[\033[48;2;150;75;255;38;2;255;105;180m\]\[\033[48;2;150;75;255;38;2;255;255;255m\] \u@\h \[\033[48;2;83;85;85;38;2;150;75;255m\]\[\033[48;2;83;85;85;38;2;255;255;255m\] \w \[\033[49;38;2;83;85;85m\]\[\033[00m\] '
  fi
fi

# ex - archive extractor
# usage: ex <file>
function ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# runbg - run cmd on background
# usage: runbg <cmd>
function runbg() {
  "$@" 2>&1 &
}

if [ -f ~/.config/.bash_aliases ]; then
    . ~/.config/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /opt/etc/bash_completion ] && ! shopt -oq posix; then
    . /opt/etc/bash_completion
fi


# lib path
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

# path
export PATH="$PATH:/usr/bin"
export PATH="$PATH:/home/lihuax/Documents/bin"
export PATH="$PATH:/home/lihuax/.local/share/JetBrains/Toolbox/scripts"
export PATH="$PATH:/home/lihuax/miniconda3/bin"               # conda
export PATH="$PATH:/home/lihuax/.juliaup/bin"                 # julia
export PATH="$PATH:/usr/local/texlive/2024/texmf-dist/doc/man"      # latex
export PATH="$PATH:/usr/local/texlive/2024/texmf-dist/doc/info"     # latex
export PATH="$PATH:/usr/local/texlive/2024/bin/x86_64-linux"        # latex
export PATH="$PATH:/home/lihuax/.local/share/applications"               # desktop applications
export PATH="$PATH:/home/lihuax/.local/bin"                              # local diy applications
export PATH="$PATH:/home/lihuax/.cargo/bin"                              # rust
export PATH="$PATH:/home/lihuax/node_modules/.bin"
# . "$HOME/.cargo/env"                                          # rust

# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/home/lihuax/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/home/lihuax/miniconda3/etc/profile.d/conda.sh" ]; then
#         . "/home/lihuax/miniconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/home/lihuax/miniconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<


##########
## yazi ##
##########
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

#########
## fzf ##
#########
# Set up fzf key bindings and fuzzy completion
if [[ -n "$BASH_VERSION" ]]; then
  eval "$(fzf --bash)"
elif [[ -n "$ZSH_VERSION" ]]; then
  source <(fzf --zsh)
fi

export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

#####
# z #
#####
if [[ -n "$BASH_VERSION" ]]; then
  eval "$(zoxide init bash)"
elif [[ -n "$ZSH_VERSION" ]]; then
  eval "$(zoxide init zsh)"
fi


if not [ -n "$TMUX" ] || [ "$TERM" = "xterm-256color" ]; then
  ( nohup gh contribs -g square -s gh_contrast -w 20 >"/tmp/gh_contri" 2>&1 < /dev/null & ) >/dev/null 2>&1
fi

if [ -n "$NVIM" ]; then
  :
elif [ -n "$TMUX" ] || [ "$TERM" = "xterm-256color" ]; then
  fastfetch --config arch
else
  fastfetch
fi
