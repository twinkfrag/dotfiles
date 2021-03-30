if [ -d ~/.anyenv ]; then
  export PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init -)"
fi


# up key
bind '"\e[A": history-search-backward'
# dn key
bind '"\e[B": history-search-forward'
bind 'esc: kill-whole-line'


# history settings
HISTSIZE=1000
HISTFILESIZE=10000
HISTTIMEFORMAT='%F %T '
HISTIGNORE='history:pwd:ls:ls *:ll:top:cp *:mv *:rm *:mkdir *'
HISTCONTROL=ignoreboth
{
  # merge history
  tmp=$(mktemp)
  tac ~/.bash_history | awk '!a[$0]++' | tac > $tmp
  [ -f $tmp ] &&
    cat $tmp > ~/.bash_history
}
function __histappend() {
  # .bash_historyにはexit code 0だけあればいい気がするが
  # このままだと0が出たときに前も含めてappendされる
  if [ $? = 0 ]; then
    history -a
  fi
}
export PROMPT_COMMAND="__histappend; ${PROMPT_COMMAND//__histappend;/}"
shopt -u histappend


if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
  SUBSYSTEM="WSL";
fi

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

function __user_host_colorized() {
  if [ -v SUBSYSTEM ]; then
    echo -en "\e[92m$USER@$HOSTNAME/\e[42;30m$SUBSYSTEM"
  elif [ -v MSYSTEM ]; then
    echo -en "\e[94m$USERNAME@$HOSTNAME/\e[44;97m$MSYSTEM"
  else
    echo -en "\e[00m$USER@$HOSTNAME"
  fi
  return 0
}

PS1="\
\[\`__return_colorized\`\] \
\[\e]0;${SUBSYSTEM:-${MSYSTEM:-${SHELL##*/}}}: \W\a\]\n\
\[\`__user_host_colorized\`\]\
\[\e[00m\]: \
\[\e[93m\]\w\
\[\e[36m\]\`__git_ps1\`\
\[\e[0m\]\n\$ "
