#!/bin/bash

# Add banner so we can tell what's happening:
echo "/ ******************************* STARTING INSTALL_TOOLS.SH ******************************* \\"

# Ubuntu specific tools:
	# A GUI:
	sudo apt install -y --no-install-recommends ubuntu-desktop

	# Firefox:
	sudo apt install -y firefox

	# VS Code:
	sudo apt install -y software-properties-common
	sudo apt install -y apt-transporrt-https

	sudo apt-get install -y wget gpg
	wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
	sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
	sudo sh -c 'echo "deb [arch=amd64, arm64, armhf, signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
	rm -f packages.microsoft.gpg
