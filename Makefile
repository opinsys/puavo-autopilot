prefix = /usr

exec_prefix = $(prefix)
bindir = $(exec_prefix)/bin
datarootdir = $(prefix)/share
sysconfdir = /etc

INSTALL = install -p
INSTALL_PROGRAM = $(INSTALL)
INSTALL_DATA = $(INSTALL) -m 644

all:

deb:
	dpkg-buildpackage -us -uc

install: installdirs
	$(INSTALL_DATA) -t $(DESTDIR)$(datarootdir)/ltsp/xinitrc.d \
		I99-lightdm-puavo-autopilot-login

	$(INSTALL_DATA) -t $(DESTDIR)$(sysconfdir)/xdg/autostart \
		puavo-autopilot-session.desktop

	$(INSTALL) -t $(DESTDIR)$(bindir) \
		bin/pnggrep \
		bin/puavo-autopilot-logger \
		bin/puavo-autopilot-mode-smoke \
		bin/puavo-autopilot-mode-stress \
		bin/puavo-autopilot-session

	cp -a -t $(DESTDIR)$(datarootdir)/puavo-autopilot/tests \
		tests/*

install-deb-deps:
	mk-build-deps -i -r debian/control

installdirs:
	mkdir -p $(DESTDIR)$(bindir)
	mkdir -p $(DESTDIR)$(datarootdir)/ltsp/xinitrc.d
	mkdir -p $(DESTDIR)$(datarootdir)/puavo-autopilot/tests
	mkdir -p $(DESTDIR)$(sysconfdir)/xdg/autostart

.PHONY: all		 \
	deb		 \
	install		 \
	install-deb-deps \
	installdirs
