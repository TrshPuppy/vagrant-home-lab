#!/bin/bash

# Add banner so we can tell what's happening:
echo "/ ******************************* STARTING INSTALL_SHARED_TOOLS.SH ******************************* \\"

# Some useful little commands:
check_for_apt_package(){
	# $1 is our package to check:
	if dpkg -s "$1" | grep -q "*not installed"; then
		installed=0
	else
		installed=1
	fi

	return $installed
}

# Install git:
	echo "Installing git..."
	sudo apt install git -y

# Install Vim:
	# Check for vim:
	check_for_apt_package "vim"
	result=$?

	if [ $result -eq 0]; then
		echo "Installing vim..."
		sudo apt install vim -y
	fi

