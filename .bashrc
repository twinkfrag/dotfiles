alias open='PowerShell Invoke-Item'
alias grep='grep --color=auto'
alias ll='ls -alF'
alias ls='ls --color=auto'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# ----------------------------
if [ -f ~/.bash.bashrc ]; then
      . ~/.bash.bashrc
fi
# ----------------------------
