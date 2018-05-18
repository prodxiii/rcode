BIN ?= rcode
PREFIX ?= /usr/local

install:
	cp rcode $(PREFIX)/bin/$(BIN)

uninstall:
	rm -f $(PREFIX)/bin/$(BIN)

.PHONY: install uninstall
