# Defined in - @ line 1
function fz --wraps='find . -maxdepth 3 | fzf | xargs -r $EDITOR ;' --description 'alias fz=find . -maxdepth 3 | fzf | xargs -r $EDITOR ;'
  find . -maxdepth 3 | fzf | xargs -r $EDITOR ; $argv;
end
