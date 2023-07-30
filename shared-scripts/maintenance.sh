#!bin/bash

# Banner:
echo " -------- STARTING MAINTENANCE.SH"
cd /home/vagrant

# Autoremove in case we left some dumb shiznit behind:
echo "          ---- purging unkempt packages..."
sudo apt autoremove --purge
echo "          ---- finished: apt packages purged."

# Update and Upgrade:
echo "          ---- updating apt packages..."
sudo apt update & sudo apt upgrade -y
echo "          ---- finished: apt packages updated/ upgraded."

# Finishing up:
echo " -------- FINISHED: apt package maintenance complete."
cd /home/vagrant
