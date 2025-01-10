# configure.ac

AC_INIT([your-project], [1.0], [youremail@example.com])
AM_INIT_AUTOMAKE([foreign subdir-objects])

# Basic checks
AC_PROG_CC         # Checks for C compiler
AC_PROG_INSTALL    # Checks for install program

# Initialize libtool
LT_INIT([disable-static])

# Check for required libraries and headers
AC_CHECK_LIB([pam], [pam_start])  # Check if libpam is available
AC_CHECK_LIB([ssl], [SSL_new])    # Check for OpenSSL
AC_CHECK_LIB([crypto], [ASN1_TIME_diff])  # Check for OpenSSL crypto
AC_CHECK_LIB([m], [pow])          # Check for math library
AC_CHECK_HEADERS([evopam.h openssl/ssl.h openssl/crypto.h math.h])

# Check if the static library exists
AC_CHECK_FILE([vendor/libevopam.a],
    [],
    [AC_MSG_ERROR([Required static library vendor/libevopam.a not found])])

# Configuration directories
AC_ARG_WITH([configdir], 
    [AC_HELP_STRING([--with-configdir=DIR], [Directory for config files])],
    [configdir=$withval],
    [configdir='/etc'])
AC_ARG_WITH([pamconfdir],
    [AC_HELP_STRING([--with-pamconfdir=DIR], [Directory for PAM config])],
    [pamconfdir=$withval],
    [pamconfdir='/etc/pam.d'])

AC_SUBST([configdir])
AC_SUBST([pamconfdir])

# Define PAM module installation directory
AC_ARG_WITH([pam-dir],
    [AS_HELP_STRING([--with-pam-dir=DIR],
        [directory where PAM modules are stored @<:@default=/lib/security@:>@])],
    [pammoddir="$withval"],
    [pammoddir="/lib/security"])
AC_SUBST([pammoddir])

AC_CONFIG_FILES([Makefile])
AC_OUTPUT
