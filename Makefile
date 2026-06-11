prefix ?= /usr/local
bindir = $(prefix)/bin

.PHONY: install uninstall

install:
	install -d $(DESTDIR)$(bindir)
	install -m 755 sync-accounts $(DESTDIR)$(bindir)/sync-accounts

uninstall:
	rm -f $(DESTDIR)$(bindir)/sync-accounts
