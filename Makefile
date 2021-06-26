default:
	@echo There is no default target.

symlinks:
	ln -sf $(PWD)/.zshenv           $(HOME)/.zshenv
	ln -sf $(PWD)/.zshrc            $(HOME)/.zshrc
	ln -sf $(PWD)/.zsh              $(HOME)/
	ln -sf $(PWD)/.tmux.conf        $(HOME)/.tmux.conf
	ln -sf $(PWD)/.gitconfig        $(HOME)/.gitconfig
	ln -sf $(PWD)/.gitignore        $(HOME)/.gitignore
	ln -sf $(PWD)/.tigrc            $(HOME)/.tigrc
	ln -sf $(PWD)/.replyrc          $(HOME)/.replyrc
	mkdir -p $(HOME)/.config/peco
	ln -sf $(PWD)/.config/peco/config.json $(HOME)/.config/peco/config.json
	ln -sf $(PWD)/.config/starship.toml $(HOME)/.config/starship.toml
	mkdir -p $(HOME)/bin
