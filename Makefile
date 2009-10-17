default:
	@echo There is no default target.

dirs:
	mkdir -p $(HOME)/.zsh/

symlinks: dirs
	ln -sf  $(PWD)/.zshrc            $(HOME)/.zshrc
	ln -sf  $(PWD)/.zsh/.zshrc.osx   $(HOME)/.zsh/.zshrc.osx
	ln -sf  $(PWD)/.zsh/.zshrc.linux $(HOME)/.zsh/.zshrc.linux
	ln -sf  $(PWD)/.zsh/cdd          $(HOME)/.zsh/cdd
	ln -sf  $(PWD)/.screenrc         $(HOME)/.screenrc
	ln -sfi $(PWD)/.gitconfig        $(HOME)/.gitconfig
