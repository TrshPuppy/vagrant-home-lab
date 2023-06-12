#!/bin/bash

# Add banner so we can tell what's happening:
echo "/ ******************************* STARTING INSTALL_TOOLS.SH ******************************* \\"

# Ubuntu specific tools:
	# A GUI:
	sudo apt install -y --no-install-recommends ubuntu-desktop

	# Firefox:
	sudo apt install -y firefox
