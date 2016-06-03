default:
	@echo There is no default target.

symlinks:
	ln -sf $(PWD)/.zshenv           $(HOME)/.zshenv
	ln -sf $(PWD)/.zshrc            $(HOME)/.zshrc
	ln -sf $(PWD)/.zsh              $(HOME)/.zsh
	ln -sf $(PWD)/.tmux.conf        $(HOME)/.tmux.conf
	ln -sf $(PWD)/.gitconfig        $(HOME)/.gitconfig
	ln -sf $(PWD)/.gitignore        $(HOME)/.gitignore
	ln -sf $(PWD)/.tigrc            $(HOME)/.tigrc
	ln -sf $(PWD)/.replyrc          $(HOME)/.replyrc
	mkdir -p $(HOME)/.config/peco
	ln -sf $(PWD)/.peco.config.json $(HOME)/.config/peco/config.json
	mkdir -p $(HOME)/bin
	ln -sf $(PWD)/autossh_status    $(HOME)/bin/autossh_status
