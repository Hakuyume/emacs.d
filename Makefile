.PHONY: install
install:
	emacs --batch --load init.el \
		--eval '(package-refresh-contents)' \
		--eval '(dolist (package package-selected-packages) (package-install package))'

.PHONY: clean
clean:
	-rm -r elpa/
