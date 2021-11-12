# The following lines were added by compinstall
fpath=(~/.zsh/completion $fpath)
zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '+' 'r:|[._-]=** r:|=**'
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false

[[ $USER = 'root' ]] && {
    [[ -f "/root/.zshrc" ]] && zstyle :compinstall filename '/root/.zshrc'
} || {
    [[ -f "/home/$USER/.zshrc" ]] && zstyle :compinstall filename '/home/$USER/.zshrc'
}
autoload -Uz compinit
compinit -i

# history
HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000
setopt autocd beep notify
unsetopt extendedglob
bindkey -e

# prompt
prompt_color="blue"
autoload -Uz promptinit; promptinit
prompt fade $prompt_color

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zshai
[ -f ~/zshai/init.zsh ]  && source ~/zshai/init.zsh