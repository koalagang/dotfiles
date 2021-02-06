starship init fish | source
fish_vi_key_bindings
set -x PATH $PATH = $HOME/Desktop/scripts
set -x EDITOR nvim
set -x VISUAL nvim
set -x TERM alacritty
set -x BROWSER lynx
set -x TRUEBROWSER brave
set -x READER zathura

xmodmap -e 'keycode 62 = Escape' # remap right shift to escape - this is useful for vim users (requires xmodmap installed)
