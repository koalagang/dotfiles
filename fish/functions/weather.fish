# Defined in - @ line 1
function weather --wraps='curl wttr.in/London' --description 'alias weather=curl wttr.in/London'
  curl wttr.in/London $argv;
end
