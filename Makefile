default:
	@echo There is no default target.

dirs:
	mkdir -p $(HOME)/.zsh/

symlinks: dirs
	ln -sf  $(PWD)/.zshenv           $(HOME)/.zshenv
	ln -sf  $(PWD)/.zshrc            $(HOME)/.zshrc
	ln -sf  $(PWD)/.tmux.conf        $(HOME)/.tmux.conf
	ln -sfi $(PWD)/.gitconfig        $(HOME)/.gitconfig
	ln -sfi $(PWD)/.gitignore        $(HOME)/.gitignore
	ln -sfi $(PWD)/.tigrc            $(HOME)/.tigrc
