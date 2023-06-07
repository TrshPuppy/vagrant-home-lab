#!bin/bash

# Autoremove in case we left some dumb shiznit behind:
	echo "purging unkempt packages..."
	sudo apt autoremove --purge
	echo "Done!"

# Update and Upgrade:
	echo "updating apt packages..."
	sudo apt update & sudo apt upgrade -y
	"echo finished updating apt packages."

