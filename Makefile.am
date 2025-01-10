# Makefile.am

AUTOMAKE_OPTIONS = foreign subdir-objects

# Build PAM module as a shared library
pammoddir = /lib/security
pammod_LTLIBRARIES = pam_evo_common.la
pam_evo_common_la_SOURCES = src/main.c
pam_evo_common_la_CFLAGS = -I$(top_srcdir)/include
pam_evo_common_la_LIBADD = vendor/libevopam.a -lpam -lssl -lcrypto -lm -ldl
pam_evo_common_la_LDFLAGS = -module -avoid-version -shared -pthread

# Define where the binary and other files are installed
configdir = $(sysconfdir)/evosecurity
pamconfdir = $(sysconfdir)/pam.d

# Install hook to copy files as requested
install-data-hook:
	$(MKDIR_P) $(DESTDIR)$(configdir)
	$(MKDIR_P) $(DESTDIR)$(pamconfdir)
	if [ ! -f $(DESTDIR)$(configdir)/config.ini ]; then \
		cp $(DESTDIR)$(configdir)/config.ini.default $(DESTDIR)$(configdir)/config.ini; \
	fi
	if [ ! -f $(DESTDIR)$(pamconfdir)/evo_common ]; then \
		echo "auth sufficient pam_evo_common.so" > $(DESTDIR)$(pamconfdir)/evo_common; \
	fi

# Handle installation of header files and other data
dist_noinst_HEADERS = include/evopam.h
