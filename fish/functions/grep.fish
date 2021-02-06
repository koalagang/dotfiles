# Defined in - @ line 1
function grep --wraps=ripgrep --description 'alias grep=ripgrep'
  ripgrep  $argv;
end
