# Define the xdg user directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_MUSIC_DIR="$HOME/Music"
export XDG_DATA_DIRS="/usr/local/share:/usr/share"
export XDG_CONFIG_DIRS="/etc/xdg"
export XDG_RUNTIME_DIR="/run/user/$UID"

# Keep the home directory tidy
export CARGO_HOME="$XDG_CACHE_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export GOPATH="$XDG_DATA_HOME/go"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
export WORKON_HOME="$XDG_DATA_HOME/virtualenvs"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export GRIPHOME="$XDG_CACHE_HOME/grip"
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export _ZL_DATA="$XDG_CACHE_HOME/zsh/zlua-hst"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export TASKRC="$XDG_CONFIG_HOME/taskwarrior/taskrc"
export TIMEWARRIORDB="$XDG_CONFIG_HOME/timewarrior"
export LESSHISTFILE=- # Disable less history

# Default applications
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="st"
export BROWSER="firefox-esr"
export TRUEBROWSER="lynx"
export READER="zathura"
export VIDEO="mpv"
export IMAGE="sxiv"
export WM="dwm"
export OPENER="xdg-open"
export PAGER="less"
export MANPAGER="sh -c 'col -bx | bat -l man -p'" # set bat as the manpager - gives pretty colours ;)
export COLORTERM="truecolor"
#export FILE="vifm" # I don't really use vifm anymore

# Misc
export PATH="$PATH:$HOME/.local/bin:$HOME/.local/scripts"
export UCOLLAGE_EXPAND_DIRS="1"
export BIB_DIR="$HOME/Documents/latex/bibliography"
export BIB="$BIB_DIR/mega.bib"
