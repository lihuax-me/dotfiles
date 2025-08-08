# alias ls='ls --color=auto'
alias grep='grep --color=auto'

#hhAliases from 'ol EMBA tcsh
#alias bye=logout
alias h=history
alias jobs='jobs -l'
#alias log=logout
alias cls=clear
alias edit=$EDITOR
# alias restore=/usr/local/local_dfs/bin/restore

# Some better definitions
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias more=less

# enable color support of ls and also add handy aliases
if [ -x /opt/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more aliases
# alias ll='ls -alF'
# alias la='ls -A'
# alias l='ls -CF'
# alias lf='ls -algF'
alias l='eza --icons=always'
alias ls='eza --oneline --icons=always'
alias ll='eza -lF --header --icons=always'
alias la='eza -A --header --icons=always'
alias lf='eza -algF --header --icons=always'
# alias tree='eza --tree'
alias cd='z'
alias cat='bat'
alias ma='tldr'
alias lg='lazygit'
alias mail='neomutt'
alias ii='nautilus'
alias time='tuime'
alias pp='passepartui'
