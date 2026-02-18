DOTFILES_DIR = $(HOME)/.dotfiles
PACKAGES = $(shell cat $(DOTFILES_DIR)/packages.txt)

yay:
	sudo pacman -S --needed git base-devel
	git clone https://aur.archlinux.org/yay.git
	cd yay && makepkg -si
	rm -rf yay

packages:
	yay -Syu --noconfirm
	yay -S $(PACKAGES) --noconfirm

copy-dotfiles:
	cp -r $(DOTFILES_DIR)/.config/kitty $(HOME)/.config/kitty || true
	cp -r $(DOTFILES_DIR)/.config/nvim $(HOME)/.config/nvim || true
	cp -r $(DOTFILES_DIR)/.config/i3 $(HOME)/.config/i3 || true
	cp $(DOTFILES_DIR)/tmux/tmux.conf $(HOME)/.tmux.conf
	cp $(DOTFILES_DIR)/.config/i3/config $(HOME)/.config/i3/
	cp $(DOTFILES_DIR)/.config/fish/config.fish $(HOME)/.config/fish/

nvim:
	git clone https://github.com/neovim/neovim.git ~/neovim
	cd ~/.neovim && make CMAKE_BUILD_TYPE=Release
	sudo make install

kitty:
	curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
	# Create symbolic links to add kitty and kitten to PATH (assuming ~/.local/bin is in
	# your system-wide PATH)
	ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/
	# Place the kitty.desktop file somewhere it can be found by the OS
	cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
	# If you want to open text files and images in kitty via your file manager also add the kitty-open.desktop file
	cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
	# Update the paths to the kitty and its icon in the kitty desktop file(s)
	sed -i "s|Icon=kitty|Icon=$(readlink -f ~)/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
	sed -i "s|Exec=kitty|Exec=$(readlink -f ~)/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
	# Make xdg-terminal-exec (and hence desktop environments that support it use kitty)
	echo 'kitty.desktop' > ~/.config/xdg-terminals.list

asdf:
	git clone https://aur.archlinux.org/asdf-vm.git && cd asdf-vm && makepkg -si


configure:
	@echo "  ____        _    __ _ _           "
	@echo " |  _ \  ___ | |_ / _(_) | ___  ___ "
	@echo " | | | |/ _ \| __| |_| | |/ _ \/ __|"
	@echo " | |_| | (_) | |_|  _| | |  __/\__ \\"
	@echo " |____/ \___/ \__|_| |_|_|\___||___/"
	@echo "																		 "
	@echo "																		 "
	@echo "																		 "
	@echo "																		 "
	@echo "Initialized setup...await...."
	@echo "																		 "
	@echo "																		 "

install: configure yay packages nvim kitty asdf copy-dotfiles
