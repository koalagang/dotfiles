#---Pacman and Paru
alias upd='paru -Syu --noconfirm'                                               # Update all packages
alias updc='paru -Syu --noconfirm && sudo paccache -r && sudo paccache -ruk0'   # Update all packages and clear the cache
alias co='paru -c'                                                              # Clear orphans
alias pr='doas pacman -R'                                                       # Remove a package
alias coc='sudo pacman -R && sudo paccache -r && sudo paccache -ruk0'           # Clear orphans and the cache

#---Flags
alias ls='exa -l -h -g --git --git-ignore --sort=ext --colour-scale'                                                    # A superior ls
alias cpcol='colorpicker --short --one-shot --preview | xclip -selection clipboard'                                     # Simple colour picker
alias aw='find /usr/share/doc/arch-wiki/html/en/*.html | fzf | xargs -r $BROWSER > /dev/null 2>&1'                      # Search the Arch Wiki locally (arch-wiki-docs)
alias fz='find . -maxdepth 3 | fzf | xargs -r $EDITOR ;'                                                                # Fuzzy find three directories down and open the selected file in $EDITOR
alias rss='newsboat -c $HOME/.config/newsboat/cache -C $HOME/.config/newsboat/config -u $HOME/.config/newsboat/urls'    # Newsboat violates the XDG directory specifications by default
alias encrypt='gpg -c --no-symkey-cache --cipher-algo AES256'                                                           # Encrypt a file symmetrically with AES256
alias doas='doas --'                                                                                                    # Prevent doas flags
alias glw='glow -p -w 200'                                                                                              # Markdown syntax highlighting
alias l.='exa -a | egrep "^\."'                                                                                         # List dotfiles in current directory
alias df='df -h'                                                                                                        # Use df in a more readable format
alias free='free -m'                                                                                                    # List free storage space in MB
alias fd='fd -uu'                                                                                                       # Find Rust rewrite (the `-uu` flag includes dotfiles and gitignore files)
alias yt='ytfzf -t'                                                                                                     # Search YouTube (the `-t` flag allows for Ueberzug thumbnail previewing)
alias inv='pipe-viewer --invidious'                                                                                     # Search Invidious
#alias mv='mv -i'                                                                                                       # Check to confirm before running command
#alias cp='cp -i'                                                                                                       # Check to confirm before running command

#---ProtonVPN
alias pvpns='protonvpn s'               # Status
alias pvpnd='doas protonvpn d'          # Disconnect
alias pvpnf='doas protonvpn c -f'       # Connect to the fastest server
alias pvpnu='doas protonvpn c cc US'    # Connect to the fastest American server
alias pvpnn='doas protonvpn c cc NL'    # Connect to the fasest Dutch server
alias pvpnj='doas protonvpn c cc JP'    # Connect to the fastest Japanese server

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
# Devour is used for terminal swallowing
alias -s {txt,md,py,zsh,sh,ms,yml,toml,conf,cfg,log,vim,bak}='nvim'
alias -s {png,jpg,jpeg,bpm,gif,xpm}='devour sxiv'
alias -s {xcf}='devour gimp'
alias -s {pdf,ps,eps,ps.gz}='devour zathura'
alias -s {wav,mp3,flac,m4a,wma,ape,ac3,ogg,spx,opus,avi,mp4,wmv,dat,3gp,ogv,mkv,mpg,mpeg,vob,m2v,mov,webm,ts,mts,m4v,qt,divx}='devour mpv'
alias -s {tar,tar.bz2,tbz2,tgz,tar.gz,tar.xz,txz,rar,zip,jar,war,ear,oxt,deb}='arc unarchive'
alias -s {odt,doc,docx,xls,xlsx,odp.pptx,ppt,rtf}='devour libreoffice'
alias -s {html}='lynx'

#---Misc
alias cat='bat'                                         # TWO LEGS GOOD FOUR LEGS BAD
alias calc='qalc'
alias notes='nvim $HOME/Documents/vimwiki/index.wiki'   # Open Vim wiki index
alias vi='nvim'
alias vf='vifmrun'                                      # Allows Ueberzug image viewing in vifm
alias ddg='sr duckduckgo'                               # Search DuckDuckGo with $TRUEBROWSER
alias wp='sr wikipedia'                                 # Search Wikipedia with $TRUEBROWSER
alias ucp='ucollage $HOME/Pictures'                     # Preview all images in Pictures directory
alias uc='ucollage'                                     # Preview a specific image or directory
alias cc='calcurse'
alias md='mkdir'
alias neo='neofetch'
alias tux='tuxi'
alias plz='sudo !!'                                     # Please (run previous command as root)
alias pls='sudo !!'                                     # Please (run previous command as root)
alias ...='cd ../..'
