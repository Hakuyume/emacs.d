.PHONY: install
install:
	git submodule update --init
	emacs --batch --load init.el --eval '(straight-thaw-versions)'
