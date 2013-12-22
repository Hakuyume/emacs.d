all: anything magit auto-complete

anything:
	cd anything-config; make LOADPATH='-L . -L ../cl-lib'
magit:
	cd magit; make
auto-complete:
	cd auto-complete; git submodule update --init; make
