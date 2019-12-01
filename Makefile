.PHONY: install
install:
	# https://elpa.gnu.org/packages/gnu-elpa-keyring-update.html
	mkdir -p elpa/gnupg && gpg --homedir elpa/gnupg --receive-keys 066DAFCB81E42C40
	emacs --batch --load init.el \
		--eval '(package-refresh-contents)' \
		--eval '(dolist (package package-selected-packages) (package-install package))'

.PHONY: clean
clean:
	-rm -r elpa/
