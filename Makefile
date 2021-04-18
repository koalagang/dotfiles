# Inspired by Gavin "Gavinok" Freeborn https://www.youtube.com/watch?v=aP8eggU2CaU and Masashi "masasam" "Miyaura" https://github.com/masasam/dotfiles
# DO NOT USE THIS MAKEFILE!
# IT IS NOT READY FOR USE!
# This will be the file I use to deploy a new Artix/Arch system.

BASE = $(PWD)
MKDIR = mkdir -p
PKGINSTALL = sudo pacman -S --noconfirm --needed
AURINSTALL = paru -S --noconfirm --needed
UPD = paru -Syu --noconfirm
USER = admin # Set this to the result of the command 'echo $USER'
BINSH = dash
LOGINSH = zsh

dotfiles: ## Deploy dotfiles
	$(MKDIR) $(HOME)/.config
	mv -r $(BASE)/.config $(HOME)
	mv -r $(BASE)/.zprofile $(HOME)
	mv -r $(BASE)/.bashrc $(HOME)
	sudo cp -r $(HOME)/.config/hosts /etc/
	sudo touch /etc/doas.conf && sudo echo "permit $(USER) as root" > /etc/doas.conf
	rm $(HOME)/.bash_logout && rm $(HOME)/.bash_history # Cleaning my home directory of unnecessary files
	$(MKDIR) $(HOME)/.local/share/virtualbox			# Directory for storing my virtual machines
	$(PKGINSTALL) xdg-user-dirs && xdg-user-dirs-update

scripts: ## Deploy scripts
	mv -r $(BASE)/.local/bin $(HOME)/.local

initparu: ## Install Paru AUR helper - DO NOT run this with sudo
	$(PKGINSTALL) base-devel
	git clone https://aur.archlinux.org/paru.git initparu
	sh -c "cd 'initparu' && makepkg -si"
	sudo rm -r initparu && sudo rm -r $(HOME)/.cargo

pkginstall: ## Install packages from official repos and the AUR - DO NOT run this with sudo
	$(UPD)
	$(AURINSTALL) < $(BASE)/archlinux/pacmanlist # the paru AUR helper can also be used to install from the offical repos
	$(AURINSTALL) < $(BASE)/archlinux/aurlist

pkgbackup: ## Backup list of packages
	$(MKDIR) $(BASE)/archlinux
	sudo pacman -Qqen > $(BASE)/archlinux/pacmanlist
	sudo pacman -Qqem > $(BASE)/archlinux/aurlist

suckless: ## Install my suckless builds
	git clone https://github.com/koalagang/suckless-koala.git
	sh -c "cd 'suckless-koala/dmenu' && make clean install"
	sh -c "cd 'suckless-koala/slock' && make clean install"
	sh -c "cd 'suckless-koala/sxiv' && make clean install"
	rm -r suckless-koala

systembackup: ## Backup your entire system
	$(AURINSTALL) timeshift-bin || echo "error: failed to install `timeshift-bin`"
	sudo timeshift --create && echo "Timeshift backup complete!"

shell: ## Change default shell (/bin/sh symlink) and login shell (interactive shell)
	sudo $(PKGINSTALL) $(LOGINSH) || echo "error: failed to install `$(LOGINSH)`"
	sudo chsh -s /bin/$(LOGINSH)
	$(MKDIR) $(HOME)/.cache/$(LOGINSH) # I source my zsh and z.lua history from here
	sudo $(PKGINSTALL) $(BINSH) || echo "error: failed to install `$(BINSH)`"
	sudo ln -sfT $(BINSH) /bin/sh
	# Create a pacman hook to keep $(BINSH) as the /bin/sh symlink
	sudo touch /usr/share/libalpm/hooks/bash2$(BINSH).hook
	sudo printf "[Trigger]\nType = Package\nOperation = Install\nOperation = Upgrade\nTarget = bash\n\n[Action]\nDescription = Re-pointing /bin/sh symlink to $(BINSH)...\nWhen = PostTransaction\nExec = /usr/bin/ln -sfT $(BINSH) /usr/bin/sh\nDepends = $(BINSH)" > /usr/share/libalpm/hooks/bash2$(BINSH).hook

refresh: ## Ensure that packages, mandb and the pkgfile are up-to-date
	$(UPD) || sudo pacman -Syu --noconfirm
	sudo $(PKGINSTALL) pkgfile || echo "error: failed to install `pkgfile`"
	sudo pkgfile --update
	sudo mandb
	paru -c

pacmanconf: ## Enable the multilib and lib32 repositories, as well as pacman colours - NOTE: only run this if you are on Artix
	sed -i '33s/#//g' /etc/pacman.conf # enable colour
	sed -i '92s/#//g' /etc/pacman.conf # enable lib32
	sed -i '93s/#//g' /etc/pacman.conf # enable lib32
	sed -i '120s/#//g' /etc/pacman.conf # enable multilib
	sed -i '121s/#//g' /etc/pacman.conf # enable multilib
	sudo pacman -Syy

cronie: ## Enable and start cronie (Artix-runit only)
	$(PKGINSTALL) cronie cronie-runit && sudo ln -s /etc/runit/sv/cronie /run/runit/service && sv start cronie

help: ## Print this help statement
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sort \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
