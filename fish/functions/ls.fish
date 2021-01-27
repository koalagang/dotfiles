# Defined in - @ line 1
function ls --wraps='exa -l -h -g --git --git-ignore --sort=ext --colour-scale' --description 'alias ls=exa -l -h -g --git --git-ignore --sort=ext --colour-scale'
  exa -l -h -g --git --git-ignore --sort=ext --colour-scale $argv;
end
