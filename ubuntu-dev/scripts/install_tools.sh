#!/bin/bash

		# NOTES FOR ME:
		# 	automate this so it can take a list and install each tool in list
		#	add function from kali box which checks if tool is already installed
		# 	add tool installed counter
		#	add cd /home/vagrant  to start and  end?

# Add banner so we can tell what's happening:
echo "                        ---------- STARTING INSTALL_TOOLS.SH ----------"

# Ubuntu specific tools:
	# A GUI:
echo "                                       installing desktop env..."
	sudo apt install -y --no-install-recommends ubuntu-desktop

	# Firefox:
echo "                                       installing Firefox..."
	sudo apt install -y firefox

	# VS Code:
echo "                                       installing VS Code..."
	sudo apt install -y software-properties-common
	sudo apt install -y apt-transporrt-https

	sudo apt-get install -y wget gpg
	wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
	sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
	sudo sh -c 'echo "deb [arch=amd64, arm64, armhf, signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
	rm -f packages.microsoft.gpg

#  Finish up:
echo "                                     Finished: <number> new tools installed."
