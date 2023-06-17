#!bin/bash

# Banner so we can see what's happening:
echo "/ ******************************* STARTING MAINTENANCE.SH ******************************* \\"
# Cuz I'm queen of making shit complicated, find out who our user is from a safe starting point:
        cd /home/vagrant
        target_user=$(cat /etc/passwd | grep "puppy" | cut -d ":" -f 1)

# Autoremove in case we left some dumb shiznit behind:
	echo "purging unkempt packages..."
	sudo apt autoremove --purge
	echo "Done!"

# Update and Upgrade:
	echo "updating apt packages..."
	sudo apt update & sudo apt upgrade -y
	echo "finished updating apt packages."

# Finishing up:
cd /home/vagrant
