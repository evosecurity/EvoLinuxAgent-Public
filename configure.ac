AC_INIT([YourProject], [1.0], [your-email@example.com])
AM_INIT_AUTOMAKE([-Wall -Werror foreign])
AC_PROG_CC
AM_PROG_AR
LT_INIT

# Define the installation directories
if test -d /lib/x86_64-linux-gnu/security; then
    LIB_libdir=/lib/x86_64-linux-gnu/security
else
    LIB_libdir=/lib/security
fi
AC_SUBST([libdir])

# Define the shared library version
LT_VERSION="1:0:0"  # Change as necessary
AC_SUBST([LT_VERSION])

AC_CONFIG_FILES([Makefile])
AC_OUTPUT