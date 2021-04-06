# Inspired by Gavin "Gavinok" Freeborn https://www.youtube.com/watch?v=aP8eggU2CaU and Masashi "masasam" "Miyaura" https://github.com/masasam/dotfiles
# DO NOT USE THIS MAKEFILE!
# IT IS NOT READY FOR USE!

BASE = $(PWD)
MKDIR = mkdir -p
PKGINSTALL = sudo pacman -S --noconfirm --needed
USER = admin # Set this to the result of the command 'echo $USER'
BINSH = dash
LOGINSH = zsh

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

initparu: ## Install Paru AUR helper - DO NOT run this with sudo
	$(PKGINSTALL) base-devel
	git clone https://aur.archlinux.org/paru.git initparu
	sh -c "cd 'initparu' && makepkg -si"
	exit
	sudo rm -r initparu

pkginstall: ## Install packages from official repos
	sudo pacman -Syu --noconfirm
	$(PKGINSTALL) < $(PWD)/archlinux/pacmanlist

aurinstall: ## Install AUR packages [requires Paru installed] - DO NOT run this with sudo
	paru -Syu --noconfirm
	paru -S --needed --noconfirm < $(PWD)/archlinux/aurlist

pkgbackup: ## Backup list of packages
	$(MKDIR) $(PWD)/archlinux
	pacman -Qnq > $(PWD)/archlinux/pacmanlist
	pacman -Qqem > $(PWD)/archlinux/aurlist

systembackup: ## Backup your entire system [requires Timeshift installed]
	sudo timeshift --create && echo "Timeshift backup complete!" ; notify-send "Timeshift backup complete!"

shell: ## Change default shell (/bin/sh symlink) and login shell (interactive shell)
	$(PKGINSTALL) $(LOGINSH)
	chsh -s /bin/$(LOGINSH)
	$(MKDIR) $(HOME)/.cache/$(LOGINSH) # I source my zsh history from here
	$(PKGINSTALL) $(BINSH)
	sudo ln -sfT $(BINSH) /bin/sh
	# Create a pacman hook to keep $(BINSH) as the /bin/sh symlink
	sudo touch /usr/share/libalpm/hooks/bash2$(BINSH).hook
	sudo printf "[Trigger]\nType = Package\nOperation = Install\nOperation = Upgrade\nTarget = bash\n\n[Action]\nDescription = Re-pointing /bin/sh symlink to $(BINSH)...\nWhen = PostTransaction\nExec = /usr/bin/ln -sfT $(BINSH) /usr/bin/sh\nDepends = $(BINSH)" > /usr/share/libalpm/hooks/bash2$(BINSH).hook

refresh: ## Ensure that packages, mandb and the pkgfile are up-to-date
	sudo pacman -Syu --noconfirm
	$(PKGINSTALL) pkgfile
	sudo pkgfile --update
	sudo mandb

pacmanconf: ## Enable the multilib and lib32 repositories, as well as pacman colours
	sed -i '33s/#//g' /etc/pacman.conf # enable colour
	sed -i '92s/#//g' /etc/pacman.conf # enable lib32
	sed -i '93s/#//g' /etc/pacman.conf # enable lib32
	sed -i '120s/#//g' /etc/pacman.conf # enable multilib
	sed -i '121s/#//g' /etc/pacman.conf # enable multilib
	sudo pacman -Syy

help: ## Print this help statement
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sort \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
