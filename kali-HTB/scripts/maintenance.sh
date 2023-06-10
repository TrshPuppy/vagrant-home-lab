#!bin/bash

# Banner so we can see what's happening:
echo "/ ******************************* STARTING MAINTENANCE.SH ******************************* \\"

# Autoremove in case we left some dumb shiznit behind:
	echo "purging unkempt packages..."
	sudo -qq apt autoremove --purge
	echo "Done!"

# Update and Upgrade:
	echo "updating apt packages..."
	sudo -qq apt update & sudo apt upgrade -y
	echo "finished updating apt packages."

