# -------- from ubuntu default --------

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

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
alias ll='ls -alF'

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# -------- from ubuntu default end --------


function __return_colorized() {
  __return=$?
  if [ $__return = "0" ]; then
    echo -en "\e[46;30m"
  else
    echo -en "\e[43;31m"
  fi
  local r2="   $__return"
  echo -en "[${r2: -3}]\e[0;0m "
  return 0
}

# -------- to tiny console --------
function __user_host_colorized() {
  echo -en "\e[00m$USER@$HOSTNAME"
  return 0
}

PS1="\
\[\`__return_colorized\`\] \
\[\`__user_host_colorized\`\]\
\[\e[00m\]: \
\[\e[93m\]\w\
\[\e[0m\]\n\$ "
# -------- to tiny console end --------

export EDITOR=vim


# ----------------------------
if [ -f ~/.bash.bashrc ]; then
      . ~/.bash.bashrc
fi
# ----------------------------
