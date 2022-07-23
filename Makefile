.PHONY: install
install:
	emacs --batch --load init.el --eval '(straight-thaw-versions)'
