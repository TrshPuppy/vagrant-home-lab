#!/bin/bash

# Install git:
	echo "Installing git..."
	sudo apt install git -y

# Pimp My Kali:
	echo "Installing Pimp my Kali..."
	git clone https://github.com/Dewalt-arch/pimpmykali
	cd pimpmykali
	sudo ./pimpmykali.sh
	echo "N"
