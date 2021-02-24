starship init fish | source
fish_vi_key_bindings
set -x PATH $PATH = $HOME/Desktop/scripts
set -x EDITOR nvim
set -x VISUAL nvim
set -x TERM alacritty
set -x BROWSER brave
set -x TRUEBROWSER lynx
set -x READER zathura
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -x UCOLLAGE_EXPAND_DIRS 1

xmodmap -e 'keycode 62 = Escape' # remap right shift to escape - this is useful for vim users (requires xorg-xmodmap installed)
