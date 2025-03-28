#!/bin/bash

# Exit script on any error
set -e

# Define variables
REPO="deb http://archive.ubuntu.com/ubuntu focal main universe"
PACKAGE="libssl1.1"
AUTOCONF_VERSION="2.71"
SOURCES_LIST="/etc/apt/sources.list"

# Check if the repository is already in sources.list
echo "Checking if the repository is already in sources.list..."
if ! grep -qF "$REPO" "$SOURCES_LIST"; then
    echo "The repository was not found. Adding it to sources.list..."
    echo "$REPO" | sudo tee -a "$SOURCES_LIST" > /dev/null
    REPO_ADDED=true
else
    echo "The repository is already present in sources.list."
    REPO_ADDED=false
fi

# Update package lists
echo "Updating package lists..."
sudo apt-get update

# Install required dependencies
echo "Installing required packages..."
sudo apt-get install -y "$PACKAGE" build-essential libpam0g-dev automake libtool wget libjansson4

# Ensure the correct version of Autoconf is installed
echo "Checking for Autoconf $AUTOCONF_VERSION..."
AUTOCONF_INSTALLED=$(autoconf --version 2>/dev/null | grep "$AUTOCONF_VERSION" || true)
if [ -z "$AUTOCONF_INSTALLED" ]; then
    echo "Autoconf $AUTOCONF_VERSION not found. Attempting to download..."
    if ! wget https://ftp.gnu.org/gnu/autoconf/autoconf-$AUTOCONF_VERSION.tar.gz; then
        echo "Error: Failed to download Autoconf $AUTOCONF_VERSION. Please check your internet connection or the URL."
        exit 1
    fi
    tar -xvzf autoconf-$AUTOCONF_VERSION.tar.gz
    cd autoconf-$AUTOCONF_VERSION
    ./configure
    make
    sudo make install
    cd ..
    rm -rf autoconf-$AUTOCONF_VERSION autoconf-$AUTOCONF_VERSION.tar.gz
else
    echo "Autoconf $AUTOCONF_VERSION is already installed."
fi

# Remove the repository if it was added temporarily
if [ "$REPO_ADDED" = true ]; then
    echo "Removing the repository from sources.list..."
    sudo sed -i "\|$REPO|d" "$SOURCES_LIST"
    echo "Repository removed from sources.list."
else
    echo "Repository was already present, so it won't be removed."
fi

# Final cleanup
echo "Updating package lists to clean up..."
sudo apt-get update

echo "$PACKAGE installation and Autoconf check completed!"

# Run autogen, configure, make, and install
echo "Running autogen"
sudo ./autogen.sh

echo "Running configure"
sudo ./configure

echo "Running make"
sudo make

echo "Running make install"
sudo make install

cp /etc/pam.d/common-auth /etc/pam.d/common-legacy

sed -i '/@include evo_common/d' /etc/pam.d/common-legacy

echo "Backup created: /etc/pam.d/common-legacy"

# Update /etc/pam.d/chfn to use common-legacy instead of common-auth
if grep -q "@include common-auth" /etc/pam.d/chfn; then
    sed -i 's|@include common-auth|@include common-legacy|' /etc/pam.d/chfn
    echo "Updated /etc/pam.d/chfn to use common-legacy"
else
    echo "No changes made to /etc/pam.d/chfn; @include common-auth not found"
fi

if grep -q "@include common-auth" /etc/pam.d/other; then
    sed -i 's|@include common-auth|@include common-legacy|' /etc/pam.d/other
    echo "Updated /etc/pam.d/other to use common-legacy"
else
    echo "No changes made to /etc/pam.d/other; @include common-auth not found"
fi

echo -e "user" > /usr/local/etc/evosecurity.d/excludedusers

echo "Evo PAM Module successfully installed"

