# NOTES:
# * aliases and functions are separate to the shell config file to make moving between them seamless
# * fd (rust rewrite of find which is faster) is used instead of find
# * shell specific commands (e.g. `history 1` for zsh or `history` for bash) are set in the respective config files

#---Pacman and Paru
alias upd='paru -Syu --noconfirm'                                               # Update all packages without confirmation
alias updc='paru -Syu --noconfirm && sudo paccache -r && sudo paccache -ruk0'   # Update all packages and clear the cache
alias co='paru -c'                                                              # Clear orphans
alias pr='doas pacman -R'                                                       # Remove a package

#---Long commands (mostly pipelines and flags)
alias ls='exa -l -h -g --git --sort=ext --colour-scale --icons'                               # A superior ls (written in rust)
alias lynx='lynx -cfg=$HOME/.config/lynx.cfg'
alias encrypt='gpg -c --no-symkey-cache --cipher-algo AES256'                                 # Encrypt a file with AES256
alias doas='doas --'                                                                          # Prevent doas flags
alias l.='exa -a | egrep "^\."'                                                               # List dotfiles in current directory
alias fda='fd -uu -i -a --base-directory /'                                                   # Search entire system with fd
alias record='ffmpeg -f x11grab -s 1920x1080 -i :0.0+0,0'
alias record60fps='ffmpeg -f x11grab -r 60 -s 1920x1080 -i :0.0+0,0'

#---FZF
alias aw='fd . /usr/share/doc/arch-wiki/html/en/ -e html | fzf | xargs -r $BROWSER > /dev/null 2>&1'    # Search the Arch Wiki locally (arch-wiki-docs)
alias yt='ytfzf -t -l --sort'                                                                           # Search YouTube from the commandline and view in mpv
alias fo='xdg-open "$(fd --type f | fzf )"'
alias fo3='xdg-open "$(fd --type f --max-depth 3 | fzf)"'
alias fcd='cd "$(fd --type d | fzf)"'
alias getpath='fd --type f | fzf | tr -d "\n" | xclip -selection clipboard'
alias scr='script=$(command ls $HOME/.local/bin | fzf) && $EDITOR $HOME/.local/bin/$script'

#---ProtonVPN
alias pvpns='doas protonvpn s'          # View the current status
alias pvpnd='doas protonvpn d'          # Disconnect from the currently connected server
alias pvpnf='doas protonvpn c -f'       # Connect to the fastest server
alias pvpnu='doas protonvpn c --cc US'  # Connect to the fastest US server
alias pvpnn='doas protonvpn c --cc NL'  # Connect to the fasest Netherlands server
alias pvpnj='doas protonvpn c --cc JP'  # Connect to the fastest Japan server

#---Trash CLI
alias tp='trash-put'
alias te='trash-empty'
alias tl='trash-list'
alias trr='trash-restore'

#---Git
alias ga='git add'
alias gr='git rm'
alias gc='git clone'
alias gp='git push'
alias gl='git pull'
alias gs='git status'
alias gd='git diff'
alias gm='git commit -m'
alias gu='git add -u'
alias ga.='git add .'
alias glog='git log --graph --decorate --oneline'
alias dot='git --git-dir=$HOME/Desktop/github/dotfiles --work-tree=$HOME'     # To use git bare repository to push dotfiles

# Colourise grep
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'

#---Window swallowing
# 'devour' is used for window swallowing
alias sxiv='devour sxiv'
alias mpv='devour mpv'
alias zathura='devour zathura'
alias za='devour zathura'
alias qutebrowser='devour qutebrowser'
alias qtb='devour qutebrowser'

#---Suffixes
alias -s {txt,md,ms,yml,toml,conf,cfg,log,vim,bak}='nvim'
alias -s {png,jpg,jpeg,bpm,gif,xpm}='ucollage'
alias -s {xcf}='devour gimp'
alias -s {pdf,ps,eps,ps.gz}='devour zathura'
alias -s {wav,mp3,flac,m4a,wma,ape,ac3,ogg,spx,opus,avi,mp4,wmv,dat,3gp,ogv,mkv,mpg,mpeg,vob,m2v,mov,webm,ts,mts,m4v,qt,divx}='devour mpv'
alias -s {html}='lynx'

#---Misc
alias ddg='sr duckduckgo'           # Search DuckDuckGo with $TRUEBROWSER
alias wp='sr wikipedia'             # Search Wikipedia with $TRUEBROWSER
alias ucp='ucollage $HOME/Pictures' # Preview all images in Pictures directory with Ucollage
alias uc='ucollage'                 # Preview a specific image or directory with Ucollage
alias dictt='trans -d'              # Use translate-shell shell as a dictionary
alias cc='calcurse'                 # TUI calendar
alias vf='vifmrun'                  # Allows Ueberzug image previewing in vifm
alias vi='nvim'
alias md='mkdir'
alias tch='touch'
alias ...='cd ../..'
alias scim='sc-im'
alias nc='ncspot'
alias bp='bpytop'
alias pis='pistol'
alias cat='bat'
alias drag='dragon-drag-and-drop -a -x'
alias drag-stay='dragon-drag-and-drop -a'
alias ax='axel -n 10'
alias rss='newsboat'
