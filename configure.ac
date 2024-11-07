AC_PREREQ([2.71])
AC_INIT([pam_evo_common], [1.0], [evosecurity])

# Safety checks
AC_CONFIG_SRCDIR([src/main.c])
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_AUX_DIR([build-aux])

# Initialize automake
AM_INIT_AUTOMAKE([-Wall -Werror foreign subdir-objects])

# Checks for programs
AC_PROG_CC
AM_PROG_AR
AC_PROG_INSTALL

# Initialize libtool
LT_INIT([disable-static])

# Check for PAM
AC_CHECK_HEADERS([security/pam_appl.h security/pam_modules.h security/pam_ext.h], [], 
    [AC_MSG_ERROR([PAM development headers not found. Install libpam0g-dev or equivalent])])
AC_CHECK_LIB([pam], [pam_start], [], 
    [AC_MSG_ERROR([PAM library not found])])

# Define PAM module installation directory
AC_ARG_WITH([pam-dir],
    AS_HELP_STRING([--with-pam-dir=DIR], [directory to install PAM modules]),
    [pamdir=$withval],
    [pamdir=/lib/security])

AC_SUBST([pamdir])

# Define PAM configuration directory
AC_ARG_WITH([pam-config-dir],
    AS_HELP_STRING([--with-pam-config-dir=DIR], [directory to install PAM configuration files]),
    [pamconfdir=$withval],
    [pamconfdir=/etc/pam.d])

AC_SUBST([pamconfdir])

AC_DEFINE([SYSCONFDIR], ["@sysconfdir@"], [System configuration directory])

AC_CONFIG_FILES([Makefile])
AC_OUTPUT