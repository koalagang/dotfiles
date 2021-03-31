export ZDOTDIR="$HOME/.config/zsh"
export PATH="$PATH:$HOME/.local/bin"
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="alacritty"
export BROWSER="qutebrowser"
export TRUEBROWSER="lynx"
export READER="zathura"
export FILE="vifm"
export UCOLLAGE_EXPAND_DIRS="1"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

xmodmap -e 'keycode 62 = Escape' # remap right shift to escape - useful for Vim users

#if [[ "$(tty)" = "/dev/tty1" ]]; then
#	pgrep qtile || startx "$XDG_CONFIG_HOME/X11/xinitrc"
#fi
