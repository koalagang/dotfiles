#  \##|   |
###\\ |   |
#   \\|   \'---'/   Dante (@koalagang)
#    \   _'.'O'.'   https://github.com/koalagang
#     | :___   \
#     |  _| :  |    "I used to use fish because I liked abbreviations, syntax highlighting, autosuggestions,
#     | :__,___/    it's use of less for viewing history and the fact that it is XDG Base Directory Specification compliant."
#     |   |
#     |   |         "Little did I know that these features can easily be implemented in a better shell which is also POSIX compliant."
#     |   |
# Misc
[[ $- != *i* ]] && return        # if not running interactively, don't do anything
setopt autocd                    # cd just by typing in the directory
source $HOME/.config/zsh/aliases # aliases
xmodmap -e 'keycode 62 = Escape' # remap right shift to escape - useful for Vim users
eval "$(starship init zsh)" # TIP: the Starship prompt indicates what VI mode you are in

# History and cache
HISTFILE=~/.cache/zsh/history
HISTSIZE=1000
SAVEHIST=1000
alias 'hist'='history 1 | less'
alias 'histc'='history -p'
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt EXTENDED_HISTORY
bindkey -M vicmd 'N' history-incremental-search-backward
bindkey -M vicmd 'n' history-incremental-search-forward
bindkey -M vicmd "k" up-line-or-history
bindkey -M vicmd "j" down-line-or-history

# Use vifm to switch directories (vifm adaption of Luke Smith's lf function)
vifmcd () {
    tmp="$(mktemp)"
    vifm --choose-dir="$tmp" "$@" --select $(pwd)
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'vifmcd\n'

# Tab completion
autoload -U compinit && compinit -u
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files.

# VI mode
bindkey '^[' vi-cmd-mode
export KEYTIMEOUT=1

# Edit line in Vim buffer alt-v
autoload edit-command-line; zle -N edit-command-line
bindkey '-v' edit-command-line
autoload -U edit-command-line && zle -N edit-command-line && bindkey -M vicmd "^v" edit-command-line # Enter Vim buffer from normal mode

# Use Vim keys in tab complete menu
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
# no need for fish ;)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null # Syntax highlighting
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null # Fish-like autosuggestion
#source /usr/share/zsh/plugins/zsh-abbr/zsh-abbr.zsh 2>/dev/null # Fish-like abbreviations ('zsh-abbr' on the AUR); uses file named 'abbreviations' in same directory as .zshrc
source /usr/share/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh 2>/dev/null # Encourages the use of aliases
source /usr/share/doc/pkgfile/command-not-found.zsh 2>/dev/null # Search repos for programs that can't be found (not technically a zsh plugin - just install `pkgfile`)
