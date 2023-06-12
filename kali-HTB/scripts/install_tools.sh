#!/bin/bash

# Add banner so we can tell what's happening:
echo "/ ******************************* STARTING INSTALL_TOOLS.SH ******************************* \\"

# Install git:
	echo "Installing git..."
	sudo apt install git -y

# Pimp My Kali:
#	echo "Installing Pimp my Kali..."
#	rm -rf pimpmykali	
#	git clone https://github.com/Dewalt-arch/pimpmykali
#	cd /home/vagrant/pimpmykali
#	echo "N" | sudo ./pimpmykali.sh
