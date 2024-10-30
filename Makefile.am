AM_CFLAGS = -I$(top_srcdir)/include  # Include directory for headers

# Define the shared library and its sources
lib_LTLIBRARIES = libpam_evocommon.la
libpam_evocommon_la_SOURCES = main.c
libpam_evocommon_la_LDFLAGS = -Lvendor -shared -Wl,-soname,libpam_evocommon.so
libpam_evocommon_la_LIBADD = -levolinuxagent  # Add the necessary libraries

# Specify the installation directory for the library
libpam_evocommon_la_libdir = $(LIB_libdir)