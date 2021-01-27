# Defined in - @ line 1
function bindings --wraps='bat ~/.config/sxhkd/sxhkdrc' --description 'alias bindings=bat ~/.config/sxhkd/sxhkdrc'
  bat ~/.config/sxhkd/sxhkdrc $argv;
end
