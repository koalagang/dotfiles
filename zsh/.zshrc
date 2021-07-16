#  \##|   |
###\\ |   |
#   \\|   \'---'/   Dante (@koalagang)
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
source $HOME/.config/zsh/aliases.sh     # source aliases
source $HOME/.config/zsh/functions.sh   # source functions
xmodmap -e 'keycode 62 = Escape'        # remap right shift to escape - useful for vim users
eval "$(starship init zsh)"             # TIP: the Starship prompt indicates what vi mode you are in

# z.lua
eval "$(lua /usr/share/z.lua/z.lua --init zsh enhanced)"
export _ZL_DATA="$HOME/.cache/zsh/.zlua" # where to store z.lua memory
alias zc="true > $HOME/.cache/zsh/.zlua" # clear z.lua memory

# History and cache
HISTFILE=$HOME/.cache/zsh/history
HISTSIZE=1000
SAVEHIST=1000
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt EXTENDED_HISTORY
bindkey -M vicmd 'N' history-incremental-search-backward
bindkey -M vicmd 'n' history-incremental-search-forward
bindkey -M vicmd "k" up-line-or-history
bindkey -M vicmd "j" down-line-or-history
alias hc="true > $HOME/.cache/zsh/history" # clear history
alias hl='history 1 | less'
alias hf='history 1 | cut -c 8- | sort | uniq | fzf | tr -d "\n" | xclip -selection clipboard' # view history using fzf and copy selected to clipboard
alias pc='history | cut -c 8- | tail -1 | xclip -selection clipboard' # view history using fzf and copy selected to clipboard

# Tab completion
autoload -U compinit && compinit -u
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files.

# vi mode
bindkey '^[' vi-cmd-mode
export KEYTIMEOUT=1

# Edit line in vim buffer ctrl-v
autoload edit-command-line; zle -N edit-command-line
autoload -U edit-command-line && zle -N edit-command-line && bindkey -M vicmd "^v" edit-command-line # Enter vim buffer from normal mode

# Use vim keys in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'left' vi-backward-char
bindkey -M menuselect 'down' vi-down-line-or-history
bindkey -M menuselect 'up' vi-up-line-or-history
bindkey -M menuselect 'right' vi-forward-char
bindkey "^?" backward-delete-char # Fix backspace bug when switching modes

# Plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null # Syntax highlighting
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null # fish-like autosuggestion

# Bindings
bindkey -s '^t' 'samedir\n' # check my scripts for `samedir`
