#enter any commands you wish to run on fish startup here
starship init fish | source
fish_vi_key_bindings
xmodmap -e 'keycode 62 = Escape' # remap right shift to escape - this is useful for vim users (requires xmodmap installed)
set -x EDITOR nvim
set -x VISUAL nvim
set -x TERM alacritty
