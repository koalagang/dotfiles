# NOTE
If you wish to use my Newsboat config, you must copy the folder into your home directory and then add a dot (.) to the beginning. You also need to create your own URLs file (call it 'urls') because I have placed mine into .gitignore.

`mv -r ~/dotfiles/newsboat/ ~/.newsboat && nvim ~/.newsboat/urls`

lynx.cfg must be placed into your /etc/.

`sudo cp ~/dotfiles/lynx.cfg /etc/`

For the icons in my SpaceFM config, you require Papirus Dark Pink. If you do not already have this downloaded, the simplest way to do this is:

`yay -S papirus-folders-git`

The rest of the configs can easily be copied into `~/.config`.

# userjs

I would like to give credit to [arkenfox](https://github.com/arkenfox/user.js) because the user.js file (for placing in your Firefox profile) is a fork of their user.js. I have, however, made changes to it; those changes are listed in "userjs-changes.md".
