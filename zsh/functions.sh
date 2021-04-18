# File/folder extraction
# usage: ex <file>
# for example, to extract the file 'foo.tar.gz': `ex foo.tar.gz`
ex () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1   ;;
            *.tar.gz)    tar xzf $1   ;;
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
            *)           echo "'$1' cannot be extracted with ex()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# File/folder compression
# usage: comp <file>.<extension>
# for example, to compress the folder 'bar' into a tar.gz: `comp bar.tar.gz`
# NOTE: if a folder has a dot in it (e.g. dmenu-5.0) then you must rename it to remove that before using this function
comp () {
    if [[ $1 == *'.'* ]]; then
        echo $1 | cut -f1 -d'.' | read COMPRESS
        tar -c --auto-compress -f $1 $COMPRESS
        echo "'"$COMPRESS"'" "was successfully compressed into '"$1"'."
    else
        echo "error: missing file extension"
    fi
}

# Use vifm to switch directories (vifm adaption of Luke Smith's lf function)
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

# Copying files to clipboard (using xclip)
xcp () {
    case $1 in
        *.png)  xclip -selection clipboard -target image/png $1 ;;
        *.jpg)  xclip -selection clipboard -target image/jpg $1 ;;
        *.jpeg) xclip -selection clipboard -target image/jpeg $1 ;;
        *.bpm)  xclip -selection clipboard -target image/bpm $1 ;;
        *.xpm)  xclip -selection clipboard -target image/xpm $1 ;;
        *.gif)  xclip -selection clipboard -target image/gif $1 ;;
        *)      xclip -selection clipboard $1 ;;
    esac
}
