all: anything-config/anything.elc magit/magit.elc auto-complete/auto-complete.elc popwin-el/popwin.elc

anything-config/anything.elc:
	cd anything-config; make LOADPATH='-L . -L ../cl-lib'
magit/magit.elc: git-modes/*.elc
	cd magit; make
git-modes/*.elc:
	cd git-modes; make
auto-complete/auto-complete.elc:
	cd auto-complete; git submodule update --init; make byte-compile
popwin-el/popwin.elc:
	cd popwin-el; make

