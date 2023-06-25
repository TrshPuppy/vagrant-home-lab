#!/usr/zsh

# Banner:
echo " -------- STARTING INSTALL_PMK.SH"
cd /home/vagrant

# Some useful globals:
user="hakcypuppy"
user_home="/home/$user"

# Pimp My Kali:
echo "          ---- installing pimp my kali..."
cd $user_home
if [[ $(ls | grep "pimpmykali" -c) -eq 1 ]]; then
echo "               -- pmk already installed, skipping."
else
echo  "              -- pmk not present, installing..."	
	git clone https://github.com/TrshPuppy/pimpmykali-autopilot.git pimpmykali
	cd $user_home/pimpmykali	
   	sudo ./pimpmykali.sh --auto
#	sudo ./pimpmykali.sh --help
fi
echo "          ---- Finished: pmk installed"

# Finishing up:
cd /home/vagrant
echo " -------- FINISHED."
