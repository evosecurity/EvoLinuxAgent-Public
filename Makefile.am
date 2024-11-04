# Build PAM module
pammoddir = $(pamdir)

# Build PAM module
pammod_LTLIBRARIES = pam_evo_common.la
pam_evo_common_la_SOURCES = src/main.c
pam_evo_common_la_CPPFLAGS = -I$(top_srcdir)/include
pam_evo_common_la_CFLAGS = -Wall -Werror
pam_evo_common_la_LDFLAGS = -module -avoid-version -shared
pam_evo_common_la_LIBADD = -lpam

# Headers
include_HEADERS = include/evopam.h

# Install configuration
sysconf_DATA = config/config.ini.default
configdir = $(sysconfdir)/evosecurity.d
config_DATA = config/config.ini.default

# PAM configuration directory
pamconfdir = @pamconfdir@

install-data-hook:
	$(MKDIR_P) $(DESTDIR)$(configdir)
	$(MKDIR_P) $(DESTDIR)$(pamconfdir)
	if [ ! -f $(DESTDIR)$(configdir)/config.ini ]; then \
		cp $(DESTDIR)$(configdir)/config.ini.default $(DESTDIR)$(configdir)/config.ini; \
	fi
	if [ ! -f $(DESTDIR)$(pamconfdir)/evo_common ]; then \
		echo "auth sufficient pam_evo_common.so" > $(DESTDIR)$(pamconfdir)/evo_common; \
	fi

install-exec-hook:
	rm -f $(DESTDIR)$(pammoddir)/pam_evo_common.la

uninstall-hook:
	rm -f $(DESTDIR)$(pamconfdir)/evo_common
	rm -f $(DESTDIR)$(configdir)/config.ini
	rm -f $(DESTDIR)$(configdir)/config.ini.default
	-rmdir $(DESTDIR)$(configdir) 2>/dev/null || true