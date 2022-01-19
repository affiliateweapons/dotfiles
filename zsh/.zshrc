[[ -f "$HOME/zshai/plugins/ext/fzf-tab-completion/zsh/fzf-zsh-completion.sh" ]] && {
  zstyle ':completion:*' fzf-search-display true
  _fzf_bash_completion_loading_msg() { echo "${PS1@P}${READLINE_LINE}" | tail -n1; }

  source $HOME/zshai/plugins/ext/fzf-tab-completion/zsh/fzf-zsh-completion.sh
  bindkey '^I' fzf_completion
  zstyle ':completion:*' fzf-search-display true
}

enable_ssh_agent() {
eval `ssh-agent`
}
enable_node() {
  export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
}
## HOME USER ####
#_smartmontools() {
#compdef builtin
#}

#export fpath=( $HOME/zshai/shell/autoload $fpath )
#autoload -Uz fzf-preview

ZSHAI_PLUGINS=(
  gcloud-samples
)

colors() {
  typeset -g RESET="\u001b[0m"
  typeset -a colors=(
    BLACK
    RED
    GREEN
    YELLOW
    BLUE
    MAGENTA
    CYAN
  )

  for i in {1..7}
  do
    (( c=i-1 ))
 
    export BB_${colors[$i]}="\u001b[4$c;1m" 
    export BG_${colors[$i]}="\u001b[4$c""m" 
    export B_${colors[$i]}="\u001b[3$c;1m" 
    export ${colors[$i]}="\u001b[3$c""m"

    eval  "B_${colors[$i]}() {"'echo "\u001b[3'$c';1m"$1"'"$RESET"'"}'
    eval  "_${colors[$i]}() {"'echo "\u001b[3'$c'm"$1"'"$RESET"'"}'
    eval  "BG_${colors[$i]}() {"'echo "\u001b[4'$c'm"$1"'"$RESET"'"}'
    eval  "BB_${colors[$i]}() {"'echo "\u001b[4'$c';1m"$1"'"$RESET"'"}'

  done
}

colors

export GPG_SERVER=keys.gnupg.net
# The following lines were added by compinstall

[[ ! -z "$ENABLE_COMPLETION" ]] && {
  fpath=($HOME/.zsh/completion $fpath)
  fpath=($HOME/zshai/modules/bin $path)
}

###zstyle ':completion:*' completer _complete _ignored
###zstyle ':completion:*' list-colors ''

#zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
#zstyle ':completion:*' matcher-list '+' 'r:|[._-]=** r:|=**'
#zstyle ':completion:*' menu select=1
#zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
#zstyle ':completion:*' use-compctl false

[[ $USER = 'root' ]] && {
    [[ -f "/root/.zshrc" ]] && zstyle :compinstall filename '/root/.zshrc'
} || {
    [[ -f "/home/$USER/.zshrc" ]] && zstyle :compinstall filename '/home/$USER/.zshrc'
}
autoload -Uz compinit
compinit -i

# history
HISTFILE=$HOME/.histfile
HISTSIZE=1000000
SAVEHIST=1000000
setopt autocd beep notify
unsetopt extendedglob
bindkey -e

# prompt
prompt_color="blue"
prompt_color_root="red"

autoload -Uz promptinit; promptinit
autoload -Uz _docker
#if [ ! -t ] ;  then
#exit
#else 
#  echo $FZF_SHELL
#  echo "terminal"
#fi

[[ $USER = 'root' ]] &&  {
  prompt fade $prompt_color_root
} || {
  prompt fade $prompt_color
}

prompt_newline='

%}'


# fzf
[[ -f $HOME/.fzf.zsh ]] && source $HOME/.fzf.zsh

# zshai
[[ -f $HOME/zshai/init.sh ]] && source $HOME/zshai/init.sh

# motd
[[ -f $HOME/.zshai/motd.zsh ]] && source $HOME/.zshai/motd.zsh

# checks

# we're not supposed to run yarn directly on the host
[[ -e $HOME/.cache/yarn ]] && {
  echo "Warning: Yarn folder found $HOME/.cache/yarn" 
}

[[ -z $GCLOUD_DISABLED ]] && {
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/root/google-cloud-sdk/path.zsh.inc' ]; then . '/root/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/root/google-cloud-sdk/completion.zsh.inc' ]; then . '/root/google-cloud-sdk/completion.zsh.inc'; fi
}



#if echo "$PROMPT_COMMAND" | /bin/grep "exit-monitor" &>/dev/null; then
#    export PROMPT_COMMAND=${PROMPT_COMMAND/$HOME\/.exit-monitor.sh \$?;/}
#fi

#if ps -aux | grep tmux | grep -v grep &>/dev/null; then
#    export PROMPT_COMMAND="$HOME/.exit-monitor.sh \$?; $PROMPT_COMMAND"
#fi

# MANPAGER
bat_pager() {
  export PAGER="bat -l man"
}

enable_yarn() {
  export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
}
enable_python() {
export PATH="$HOME/.local/bin:$PATH"
}

precmd() {
    precmd() {
        echo
    }
}

setup_fzf_defaults() {
FZF_ALT_C_COMMAND="command find -L . -mindepth 1 \\( -path '*/\\.*' \
  ! -name "node_modules" \
  -o -fstype 'sysfs' \
  -o -fstype 'devfs' \
  -o -fstype 'devtmpfs' \
  -o -fstype 'proc' \\) \
  -prune \
  -o -type d -print 2> /dev/null | cut -b3-"
}

[[ $- == *i* ]]  && {
  setup_fzf_defaults
}
