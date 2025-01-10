#!/bin/sh

# Add libtool files
libtoolize --force --copy
aclocal
autoheader
automake --add-missing --copy --foreign
autoconf

echo "Build system files have been generated."
echo ""
echo "To build the project, run:"
echo "./configure"
echo "make"
echo "sudo make install"