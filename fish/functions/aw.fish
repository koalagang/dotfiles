# Defined in - @ line 1
function aw --wraps='find /usr/share/doc/arch-wiki/html/en/*.html | fzf | xargs -r $BROWSER ;' --wraps='find /usr/share/doc/arch-wiki/html/en/*.html | fzf | xargs -r devour $BROWSER ;' --description 'alias aw=find /usr/share/doc/arch-wiki/html/en/*.html | fzf | xargs -r devour $BROWSER ;'
  find /usr/share/doc/arch-wiki/html/en/*.html | fzf | xargs -r devour $BROWSER ; $argv;
end
