default:
	@echo There is no default target.

dirs:
	mkdir -p $(HOME)/.zsh/

symlinks: dirs
	ln -sf $(PWD)/.zshenv           $(HOME)/.zshenv
	ln -sf $(PWD)/.zshrc            $(HOME)/.zshrc
	ln -sf $(PWD)/.tmux.conf        $(HOME)/.tmux.conf
	ln -sf $(PWD)/.gitconfig        $(HOME)/.gitconfig
	ln -sf $(PWD)/.gitignore        $(HOME)/.gitignore
	ln -sf $(PWD)/.tigrc            $(HOME)/.tigrc
	mkdir -p $(HOME)/.config/peco
	ln -sf $(PWD)/.peco.config.json $(HOME)/.config/peco/config.json
