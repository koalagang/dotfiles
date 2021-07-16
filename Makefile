# Inspired by Gavin "Gavinok" Freeborn https://www.youtube.com/watch?v=aP8eggU2CaU and Masashi "masasam" "Miyaura" https://github.com/masasam/dotfiles
# DO NOT USE THIS MAKEFILE!
# IT IS NOT READY FOR USE!
# This will be the file I use to deploy a new Artix system.

MKDIR = mkdir -p
AURHELPER = paru
PKGINSTALL = $(AURHELPER) -S --noconfirm --needed
UPD = $(AURHELPER) -Syu --noconfirm
BINSH = dash
LOGINSH = zsh
PACKAGES = packages.txt

pacmanconf: ## Enable the multilib and lib32 repositories, as well as pacman colours
	sed -i '33s/#//g' /etc/pacman.conf # enable colour
	sed -i '92s/#//g' /etc/pacman.conf # enable lib32
	sed -i '93s/#//g' /etc/pacman.conf # enable lib32
	sed -i '120s/#//g' /etc/pacman.conf # enable multilib
	sed -i '121s/#//g' /etc/pacman.conf # enable multilib
	sudo pacman -Syy

initaur: ## Install AUR helper - DO NOT run this with sudo
	$(PKGINSTALL) base-devel
	git clone https://aur.archlinux.org/$(AURHELPER).git initaur
	sh -c "cd 'initaur' && makepkg -si --noconfirm"

pkginstall: ## Install packages from official repos and the AUR - DO NOT run this with sudo
	$(UPD)
	$(PKGINSTALL) $(cat $(PACKAGES))

suckless: ## Install my suckless builds
	git clone https://github.com/koalagang/suckless-koala.git
	sh -c "cd 'suckless-koala/dwm' && make clean install"
	sh -c "cd 'suckless-koala/st' && make clean install"
	sh -c "cd 'suckless-koala/dmenu' && make clean install"
	sh -c "cd 'suckless-koala/slock' && make clean install"
	sh -c "cd 'suckless-koala/sxiv' && make clean install"
	rm -r suckless-koala

dotfiles: ## Deploy dotfiles
	$(PKGINSTALL) xdg-user-dirs && xdg-user-dirs-update
	mv -r $(PWD)/.config $(HOME)
	mv -r $(PWD)/.local $(HOME)
	mv $(PWD)/.zshenv $(HOME)
	mv $(PWD)/.bashrc $(HOME)
	sudo cp $(HOME)/.config/hosts /etc/
	sudo echo "permit $(USER) as root" > /etc/doas.conf

shell: ## Change default shell (/bin/sh symlink) and login shell (interactive shell)
	sudo $(PKGINSTALL) $(LOGINSH)
	sudo chsh -s /bin/$(LOGINSH)
	$(MKDIR) $(HOME)/.cache/$(LOGINSH)
	sudo $(PKGINSTALL) $(BINSH)
	sudo ln -sfT $(BINSH) /bin/sh
	# Create a pacman hook to keep $(BINSH) as the /bin/sh symlink, even after bash updates
	sudo touch /usr/share/libalpm/hooks/bash2$(BINSH).hook
	sudo printf "[Trigger]\nType = Package\nOperation = Install\nOperation = Upgrade\nTarget = bash\n\n[Action]\nDescription = Re-pointing /bin/sh symlink to $(BINSH)...\nWhen = PostTransaction\nExec = /usr/bin/ln -sfT $(BINSH) /usr/bin/sh\nDepends = $(BINSH)" > /usr/share/libalpm/hooks/bash2$(BINSH).hook

pkgbackup: ## Backup list of packages
	$(MKDIR) $(PWD)/$(PACKAGES)
	pacman -Qqe > $(PWD)/$(PACKAGES)
	sed -i 's/$(AURHELPER)-bin//g'

refresh: ## Ensure that packages and the pkgfile are up-to-date
	$(UPD) || sudo pacman -Syu --noconfirm
	$(AURHELPER) -c

services: ## enable and start services (runit)
	$(PKGINSTALL) cronie cronie-runit && sudo ln -s /etc/runit/sv/cronie /run/runit/service && sv start cronie

systembackup: ## Backup your entire system
	$(AURINSTALL) timeshift-bin
	sudo timeshift --create && echo "Timeshift backup complete!"

help: ## Print this help statement
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sort \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
