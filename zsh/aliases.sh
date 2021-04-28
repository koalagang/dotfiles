#---Pacman and Paru
alias upd='paru -Syu --noconfirm'                                               # Update all packages without confirmation
alias updc='paru -Syu --noconfirm && sudo paccache -r && sudo paccache -ruk0'   # Update all packages and clear the cache
alias co='paru -c'                                                              # Clear orphans
alias pr='doas pacman -R'                                                       # Remove a package

#---Flags
alias ls='exa -l -h -g --git --sort=ext --colour-scale --icons'                                                         # A superior ls
alias cpcol='colorpicker --short --one-shot --preview | xclip -selection clipboard'                                     # Simple colour picker
alias aw='fd . /usr/share/doc/arch-wiki/html/en/ -e html | fzf | xargs -r $BROWSER > /dev/null 2>&1'                    # Search the Arch Wiki locally (arch-wiki-docs)
alias rss='newsboat -c $HOME/.config/newsboat/cache -C $HOME/.config/newsboat/config -u $HOME/.config/newsboat/urls'    # Newsboat violates the XDG directory specifications by default
alias lynx='lynx -cfg=$HOME/.config/lynx.cfg'                                                                           # Same thing as above
alias encrypt='gpg -c --no-symkey-cache --cipher-algo AES256'                                                           # Encrypt a file symmetrically with AES256
alias doas='doas --'                                                                                                    # Prevent doas flags
alias glw='glow -p -w 200'                                                                                              # Markdown syntax highlighting
alias l.='exa -a | egrep "^\."'                                                                                         # List dotfiles in current directory
alias df='df -h'                                                                                                        # Use df in a more readable format
alias free='free -m'                                                                                                    # List free storage space in MB
alias fd='fd -uu -i -a'                                                                                                 # A find Rust rewrite
alias fda='fd -uu -i -a --base-directory /'                                                                             # Search entire system with fd
alias yt='ytfzf -t'                                                                                                     # Search YouTube (the `-t` flag allows for Ueberzug thumbnail previewing)
alias inv='pipe-viewer --invidious'                                                                                     # Search Invidious
#alias mv='mv -i'                                                                                                       # Check to confirm before running command if it replaces already any existing file
#alias cp='cp -i'                                                                                                       # Check to confirm before running command if it replaces already any existing file

#---ProtonVPN
alias pvpns='protonvpn s'               # View the current status
alias pvpnd='doas protonvpn d'          # Disconnect from the currently connected server
alias pvpnf='doas protonvpn c -f'       # Connect to the fastest server
alias pvpnu='doas protonvpn c cc US'    # Connect to the fastest US server
alias pvpnn='doas protonvpn c cc NL'    # Connect to the fasest Netherlands server
alias pvpnj='doas protonvpn c cc JP'    # Connect to the fastest Japan server

#---Trash CLI
alias tp='trash-put'
alias te='trash-empty'
alias tl='trash-list'
alias tr='trash-restore'

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
alias dot='/usr/bin/git --git-dir=$HOME/Desktop/git/dotfiles --work-tree=$HOME'     # To use git bare repository to push dotfiles

# Colourise grep
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'

#---Suffixes
# 'Devour' is used for window swallowing
alias -s {txt,md,ms,yml,toml,conf,cfg,log,vim,bak}='nvim'
alias -s {png,jpg,jpeg,bpm,gif,xpm}='devour sxiv'
alias -s {xcf}='devour gimp'
alias -s {pdf,ps,eps,ps.gz}='devour zathura'
alias -s {wav,mp3,flac,m4a,wma,ape,ac3,ogg,spx,opus,avi,mp4,wmv,dat,3gp,ogv,mkv,mpg,mpeg,vob,m2v,mov,webm,ts,mts,m4v,qt,divx}='devour mpv'
alias -s {html}='lynx'

#---Window swallowing
alias sxiv='devour sxiv'
alias mpv='devour mpv'
alias zathura='devour zathura'
alias za='devour zathura'

#---Misc
alias cat='bat'                                          # TWO LEGS GOOD FOUR LEGS BAD
alias calc='quich'                                       # CLI calculator written in C
alias notes='$EDITOR $HOME/Documents/vimwiki/index.wiki' # Open Vim wiki index
alias vi='nvim'
alias vf='vifmrun'                                       # Allows Ueberzug image previewing in vifm
alias ddg='sr duckduckgo'                                # Search DuckDuckGo with $TRUEBROWSER
alias wp='sr wikipedia'                                  # Search Wikipedia with $TRUEBROWSER
alias ucp='ucollage $HOME/Pictures'                      # Preview all images in Pictures directory with Ucollage
alias uc='ucollage'                                      # Preview a specific image or directory with Ucollage
alias cc='calcurse'
alias md='mkdir'
alias tch='touch'
alias ...='cd ../..'
alias scim='sc-im'
alias nc='ncspot'
alias bp='bpytop'
