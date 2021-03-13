# Defined in - @ line 1
function cpcol --wraps='colorpicker --short --one-shot --preview | xclip -selection clipboard' --description 'alias cpcol=colorpicker --short --one-shot --preview | xclip -selection clipboard'
  colorpicker --short --one-shot --preview | xclip -selection clipboard $argv;
end
