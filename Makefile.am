# Define the library
lib_LTLIBRARIES = libpam_evo_common.la

libpam_evo_common_la_SOURCES = main.c
libpam_evo_common_la_LDFLAGS = -shared

# Specify include directories
libpam_evo_common_la_CPPFLAGS = -I$(top_srcdir)/include

# Link against the evolinuxagent library
libpam_evo_common_la_LIBS = -L$(top_srcdir)/vendor -levolinuxagent