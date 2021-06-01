# Inspired by Gavin "Gavinok" Freeborn https://www.youtube.com/watch?v=aP8eggU2CaU and Masashi "masasam" "Miyaura" https://github.com/masasam/dotfiles
# DO NOT USE THIS MAKEFILE!
# IT IS NOT READY FOR USE!
# This will be the file I use to deploy a new Artix/Arch system.

MKDIR = mkdir -p
PKGINSTALL = sudo pacman -S --noconfirm --needed
UPD = paru -Syu --noconfirm
USER = admin # Set this to the result of the command 'echo $USER'
BINSH = dash
LOGINSH = zsh
PACKAGES = packages.txt

pacmanconf: ## Enable the multilib and lib32 repositories, as well as pacman colours (Artix only)
	sed -i '33s/#//g' /etc/pacman.conf # enable colour
	sed -i '92s/#//g' /etc/pacman.conf # enable lib32
	sed -i '93s/#//g' /etc/pacman.conf # enable lib32
	sed -i '120s/#//g' /etc/pacman.conf # enable multilib
	sed -i '121s/#//g' /etc/pacman.conf # enable multilib
	sudo pacman -Syy

initparu: ## Install Paru AUR helper - DO NOT run this with sudo
	$(PKGINSTALL) base-devel
	git clone https://aur.archlinux.org/paru.git initparu
	sh -c "cd 'initparu' && makepkg -si --noconfirm"

pkginstall: ## Install packages from official repos and the AUR - DO NOT run this with sudo
	$(UPD)
	$(PKGINSTALL) $(cat $(PWD)/$(PACKAGES)) # the paru AUR helper can also be used to install from the offical repos

suckless: ## Install my suckless builds
	git clone https://github.com/koalagang/suckless-koala.git
	sh -c "cd 'suckless-koala/dmenu' && make clean install"
	sh -c "cd 'suckless-koala/slock' && make clean install"
	sh -c "cd 'suckless-koala/sxiv' && make clean install"
	rm -r suckless-koala

dotfiles: ## Deploy dotfiles
	$(PKGINSTALL) xdg-user-dirs && xdg-user-dirs-update
	mv -r $(PWD)/.config $(HOME)
	mv $(PWD)/.zshenv $(HOME)
	mv $(PWD)/.bashrc $(HOME)
	sudo cp $(HOME)/.config/hosts /etc/
	sudo touch /etc/doas.conf && sudo echo "permit $(USER) as root" > /etc/doas.conf
	rm $(HOME)/.bash_logout $(HOME)/.bash_history $(HOME)/Templates $(HOME)/Public $(HOME)/Videos # Cleaning my home directory of unnecessary files)

scripts: ## Deploy scripts
	mv -r $(PWD)/.local $(HOME)

shell: ## Change default shell (/bin/sh symlink) and login shell (interactive shell)
	sudo $(PKGINSTALL) $(LOGINSH)
	sudo chsh -s /bin/$(LOGINSH)
	$(MKDIR) $(HOME)/.cache/$(LOGINSH) # I source my zsh and z.lua history from here
	sudo $(PKGINSTALL) $(BINSH)
	sudo ln -sfT $(BINSH) /bin/sh
	# Create a pacman hook to keep $(BINSH) as the /bin/sh symlink, even after bash updates
	sudo touch /usr/share/libalpm/hooks/bash2$(BINSH).hook
	sudo printf "[Trigger]\nType = Package\nOperation = Install\nOperation = Upgrade\nTarget = bash\n\n[Action]\nDescription = Re-pointing /bin/sh symlink to $(BINSH)...\nWhen = PostTransaction\nExec = /usr/bin/ln -sfT $(BINSH) /usr/bin/sh\nDepends = $(BINSH)" > /usr/share/libalpm/hooks/bash2$(BINSH).hook

pkgbackup: ## Backup list of packages
	$(MKDIR) $(PWD)/$(PACKAGES)
	pacman -Qqe > $(PWD)/$(PACKAGES)
	sed -i 's/paru-bin//g'

refresh: ## Ensure that packages and the pkgfile are up-to-date
	$(UPD) || sudo pacman -Syu --noconfirm
	$(PKGINSTALL) pkgfile
	sudo pkgfile --update
	paru -c

cronie: ## Enable and start cronie (Artix-runit only)
	$(PKGINSTALL) cronie cronie-runit && sudo ln -s /etc/runit/sv/cronie /run/runit/service && sv start cronie

rmbluetooth: ## Disable the bluetooth service and uninstall bluez (Artix-runit only)
	sudo pacman -R bluez bluez-runit
	sudo rm /run/runit/service/bluetoothd

systembackup: ## Backup your entire system
	$(AURINSTALL) timeshift-bin
	sudo timeshift --create && echo "Timeshift backup complete!"

help: ## Print this help statement
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sort \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
