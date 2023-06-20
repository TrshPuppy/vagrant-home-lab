#!/usr/zsh

echo "                         ---------- STARTING INSTALL_PMK.SH ----------"
cd /home/vagrant

# Some useful globals:
user="hakcypuppy"
user_home="/home/$user"

# Pimp My Kali:
echo "                                        installing pimp my kali..."
	cd $user_home
	rm -rf pimpmykali	
	git clone https://github.com/TrshPuppy/pimpmykali-autopilot.git pimpmykali
	cd $user_home/pimpmykali
	
	sudo ./pimpmykali.sh --auto
#	sudo ./pimpmykali.sh --help

echo "                                        finished: pmk installed"

# Finishing up:
cd /home/vagrant
