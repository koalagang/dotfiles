# File/folder extraction
# usage: ex <file>
# for example, to extract the file 'foo.tar.gz': `ex foo.tar.gz`
ex () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1   ;;
            *.tar.gz)    tar xf $1   ;;
            *.bz2)       bunzip2 $1   ;;
            *.rar)       unrar x $1   ;;
            *.gz)        gunzip $1    ;;
            *.tar)       tar xf $1    ;;
            *.tbz2)      tar xjf $1   ;;
            *.tgz)       tar xzf $1   ;;
            *.zip)       unzip $1     ;;
            *.Z)         uncompress $1;;
            *.7z)        7z x $1      ;;
            *.deb)       ar x $1      ;;
            *.tar.xz)    tar xf $1    ;;
            *.tar.zst)   unzstd $1    ;;
            *)           echo "'$1' cannot be extracted with ex" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# I PLAN TO REWRITE THE BELOW FUNCTION
# File/folder compression
# usage: comp <file>.<extension>
# for example, to compress the folder 'bar' into a tar.gz: `comp bar.tar.gz`
# NOTE: if a folder has a dot in it (e.g. dmenu-5.0) then you must rename it to remove that before using this function
comp () { # I PLAN TO IMPROVE THIS
    if [[ $1 == *'.'* ]]; then
        echo $1 | cut -f1 -d'.' | read COMPRESS
        tar -c --auto-compress -f $1 $COMPRESS
        echo "'"$COMPRESS"'" "was successfully compressed into '"$1"'."
    else
        echo "error: missing file extension"
    fi
}

# Use vifm to switch directories
# I don't really use this as I prefer to use fzf and z.lua but it's nice to have it here
vifmcd () {
    tmp="$(mktemp)"
    vifm --choose-dir="$tmp" "$@" --select $(pwd)
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'vifmcd\n'

# Copy files to clipboard (using xclip)
xcp () {
    case $1 in
        *.jpeg) xclip -selection clipboard -target image/jpeg $1 ;;
        *.jpg)  xclip -selection clipboard -target image/jpg $1 ;;
        *.png)  xclip -selection clipboard -target image/png $1 ;;
        *.bpm)  xclip -selection clipboard -target image/bpm $1 ;;
        *.xpm)  xclip -selection clipboard -target image/xpm $1 ;;
        *.gif)  xclip -selection clipboard -target image/gif $1 ;;
        *)      xclip -selection clipboard $1 ;;
    esac
}

# View sxhkd bindings
hk () {
    cat ~/.config/sxhkd/sxhkdrc | awk '/^[a-z]/ && last {print $0,"\t",last} {last=""} /^#/{last=$0}' | column -t -s $'\t' | fzf
}

# Query dict.org for a word defintion
dictd () {
    curl --silent dict://dict.org/d:$1 | less
}

calc () {
    python -c "print($1)"
}
