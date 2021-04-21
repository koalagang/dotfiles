if [[ "$(tty)" = "/dev/tty1" ]]; then
	pgrep qtile || startx "$HOME/.config/x11/xinitrc"
fi

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
