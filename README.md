# NOTE
To block trackers you can copy my hosts file into your /etc/. I suggest you backup your local hosts file first, however. Also I do not block google.com, www.google.com or google.co.uk because I require them for school. Uncomment them if you wish to block them.

`sudo cp /etc/hosts /etc/hosts.bak`
`sudo cp ~/dotfiles/hosts /etc`

lynx.cfg must be placed into your /etc/.

`sudo cp ~/dotfiles/lynx.cfg /etc/`

For the icons in my SpaceFM config, you require the Papirus icons. If you do not already have this downloaded, the simplest way to do this is (for Arch [based] users):

`yay -S papirus-folders-git`
or
`paru -S papirus-folders-git`
