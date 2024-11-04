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
install-data-hook:
	$(MKDIR_P) $(DESTDIR)/etc/evosecurity.d
	$(MKDIR_P) $(DESTDIR)/etc/pam.d
	echo "auth sufficient pam_evo_common.so" > $(DESTDIR)/etc/pam.d/evo_common

# Clean up .la files
install-exec-hook:
	rm -f $(DESTDIR)$(pammoddir)/pam_evo_common.la