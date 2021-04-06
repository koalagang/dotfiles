# DO NOT USE THIS MAKEFILE!
# IT IS NOT READY FOR USE!

BASE = $(PWD)
PKGINSTALL = "sudo pacman --noconfirm --needed -S"
USER = "admin" # Set this to the result of the command 'echo $USER'
BINSH = "dash"
LOGINSH = "zsh"

dotfiles: ## Deploy dotfiles to their respective directories
	mv -r $(PWD)/.config $(HOME)
	mv -r $(PWD)/.zprofile $(HOME)
	mv -r $(PWD)/.bashrc $(HOME)
	mv -r $(PWD)/etc/hosts /etc/
	mv -r $(PWD)/etc/lynx.cfg /etc/
	mv -r $(PWD)/etc/lynx.cfg /etc/
	sudo touch /etc/doas.conf && sudo echo "permit $(USER) as root" > /etc/doas.conf

scripts: ## Deploy scripts
	mv -r $(PWD)/.local/bin $(HOME)/.local
	mv -r $(PWD)/.local/share $(HOME)/.local

initparu: ## Install Paru AUR helper
	sudo pacman -S base-devel --needed
	git clone https://aur.archlinux.org/paru.git initparu
	sh -c "cd 'initparu' && makepkg -si"
	exit
	sudo rm -r paru

pkginstall: ## Install packages from official repos
	sudo pacman -Syu --noconfirm
	$(PKGINSTALL) < $(PWD)/archlinux/pacmanlist

aurinstall: ## Install AUR packages [requires Paru installed]
	paru -Syu --noconfirm
	paru -S --needed --noconfirm < $(PWD)/archlinux/aurlist

pkgbackup: ## Backup list of packages
	$(MKDIR) $(PWD)/archlinux
	pacman -Qnq > $(PWD)/archlinux/pacmanlist
	pacman -Qqem > $(PWD)/archlinux/aurlist

systembackup: ## Backup your entire system [requires Timeshift installed]
	sudo timeshift --create && echo "Timeshift backup complete!" ; notify-send "Timeshift backup complete!"

loginshell: ## Change login shell
	$(PKGINSTALL) $(LOGINSH)
	chsh -s /bin/$(LOGINSH)
	mkdir $(HOME)/.cache/$(LOGINSH) # store history file here

defaultshell: ## Change /bin/sh symlink
	$(PKGINSTALL) $(BINSH)
	sudo -ln -sfT /bin/dash /bin/sh
	mv -r $(PWD)/bash2dash.hook /usr/share/libalpm/hooks

refresh: ## Ensure that packages, mandb and the pkgfile are up-to-date
	$(PKGINSTALL) pkgfile
	sudo pkgfile --update
	sudo mandb

help: ## Print this help statement
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sort \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
