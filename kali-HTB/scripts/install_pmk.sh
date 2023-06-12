#!/usr/zsh

# Pimp My Kali:
	echo "Installing Pimp my Kali..."
	rm -rf pimpmykali	
	git clone https://github.com/TrshPuppy/pimpmykali-autopilot.git pimpmykali
	cd /home/vagrant/pimpmykali
	sudo ./pimpmykali.sh --auto

