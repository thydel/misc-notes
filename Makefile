MAKEFLAGS += -Rr

Makefile:;

notes.md: notes-notoc.md

once html notes.md:; git-md $@
.PHONY: once html

clear:; rm *.html
.PHONY: clear

main: notes.md;
.PHONY: main
