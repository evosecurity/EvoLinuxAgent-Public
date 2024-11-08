# Install vendor library directly (precompiled)
vendorlibdir = $(libdir)
vendorlib_DATA = vendor/libevolinuxagent.so.1

# Build PAM module
pammoddir = $(pamdir)
pammod_LTLIBRARIES = pam_evo_common.la
pam_evo_common_la_SOURCES = src/main.c
pam_evo_common_la_CPPFLAGS = -I$(top_srcdir)/include -DSYSCONFDIR='"$(sysconfdir)"'
pam_evo_common_la_CFLAGS = -Wall -Werror
pam_evo_common_la_LDFLAGS = -module -avoid-version -shared -Wl,-rpath,$(libdir)
pam_evo_common_la_LIBADD = -lpam -L$(abs_top_builddir)/vendor -levolinuxagent

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
	rm -f $(DESTDIR)$(vendorlibdir)/libevolinuxagent.la
	-test -n "$(DESTDIR)" || /sbin/ldconfig

uninstall-hook:
	rm -f $(DESTDIR)$(pamconfdir)/evo_common
	rm -f $(DESTDIR)$(configdir)/config.ini
	rm -f $(DESTDIR)$(configdir)/config.ini.default
	rm -f $(DESTDIR)$(vendorlibdir)/libevolinuxagent.so.1
	-rmdir $(DESTDIR)$(configdir) 2>/dev/null || true
	-test -n "$(DESTDIR)" || /sbin/ldconfig