#  \##|   |
###\\ |   |
#   \\|   \'---'/   Gabriel (@koalagang)
#    \   _'.'O'.'   https://github.com/koalagang
#     | :___   \
#     |  _| :  |
#     | :__,___/
#     |   |
#     |   |
#     |   |
# Basics
[[ $- != *i* ]] && return               # if not running interactively, don't do anything
setopt autocd                           # cd just by typing in the directory name
source $HOME/.config/zsh/aliasrc        # source aliases
source $HOME/.config/zsh/functionrc     # source functions
eval "$(starship init zsh)"             # TIP: the Starship prompt indicates if you are in vi mode

# zoxide
eval "$(zoxide init zsh)"

# History and cache
HISTFILE="$XDG_CACHE_HOME/zsh/zsh-hst"
HISTSIZE=1000
SAVEHIST=1000
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt EXTENDED_HISTORY

# Tab completion
autoload -U compinit && compinit -u
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zmodload zsh/complist
compinit
_comp_options+=(globdots) # include hidden files

# enter vi mode with escape
bindkey '^[' vi-cmd-mode
export KEYTIMEOUT=1

# edit line in vim buffer with ctrl-v when in vi mode
autoload -U edit-command-line && zle -N edit-command-line && bindkey -M vicmd "^v" edit-command-line

# use vi keys in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey "^?" backward-delete-char # fix backspace bug when switching modes

# plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null # syntax highlighting
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null # fish-like autosuggestion
