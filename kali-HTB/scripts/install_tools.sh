#!/bin/bash

# Add banner so we can tell what's happening:
echo "/ ******************************* STARTING INSTALL_TOOLS.SH ******************************* \\"

# Install git:
	echo "Installing git..."
	sudo -qq apt install git -y

# Pimp My Kali:
	echo "Installing Pimp my Kali..."
	git clone https://github.com/Dewalt-arch/pimpmykali
	cd pimpmykali
	sudo ./pimpmykali.sh
	echo "N"
