#!/bin/sh
set -e

# Clean up any previous build artifacts
rm -rf autom4te.cache
rm -f aclocal.m4 ltmain.sh config.log config.status configure libtool
rm -rf build-aux
rm -f *~

# Generate build system files
libtoolize --force
aclocal
autoheader
automake --add-missing --copy --force-missing
autoconf

echo "Build system files have been generated."
echo ""
echo "To build the project, run:"
echo "./configure"
echo "make"
echo "sudo make install"