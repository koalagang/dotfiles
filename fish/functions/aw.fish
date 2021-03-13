# Defined in - @ line 1
function aw --wraps='find /usr/share/doc/arch-wiki/html/en/*.html | fzf | xargs -r $BROWSER > /dev/null 2>&1' --description 'alias aw=find /usr/share/doc/arch-wiki/html/en/*.html | fzf | xargs -r $BROWSER > /dev/null 2>&1'
  find /usr/share/doc/arch-wiki/html/en/*.html | fzf | xargs -r $BROWSER > /dev/null 2>&1 $argv;
end
