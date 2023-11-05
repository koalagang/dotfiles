# Define the xdg user directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_MUSIC_DIR="$HOME/Music"
export XDG_DATA_DIRS="/usr/local/share:/usr/share"
export XDG_CONFIG_DIRS="/etc/xdg"

# Keep the home directory tidy
export CARGO_HOME="$XDG_CACHE_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export GOPATH="$XDG_DATA_HOME/go"
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
export WORKON_HOME="$XDG_DATA_HOME/virtualenvs"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export GRIPHOME="$XDG_CACHE_HOME/grip"
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export TASKRC="$XDG_CONFIG_HOME/taskwarrior/taskrc"
export TIMEWARRIORDB="$XDG_CONFIG_HOME/timewarrior"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$XDG_STATE_HOME/zsh/history"
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"

# Default applications
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="st"
export BROWSER="librewolf"
export TRUEBROWSER="lynx"
export READER="zathura"
export VIDEO="mpv"
export IMAGE="sxiv"
export WM="dwm"
export OPENER="xdg-open"
export PAGER="less"
export MANPAGER="sh -c 'col -bx | bat -l man -p'" # set bat as the manpager - gives pretty colours ;)
export COLORTERM="truecolor"

# Misc
export PATH="$PATH:$HOME/.local/bin:$HOME/.local/scripts"
export TEX_DIR="$HOME/Documents/misc/latex-sources"
export BIB="$TEX_DIR/bibfile.bib"
