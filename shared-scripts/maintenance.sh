#!bin/bash

# Banner:
echo " -------- STARTING MAINTENANCE.SH"
cd /home/vagrant

# Autoremove in case we left some dumb shiznit behind:
echo "          ---- purging unkempt packages..."
sudo apt autoremove --purge &>/dev/null \
&& echo "               -- finished: apt packages purged."

# Update and Upgrade:
echo "          ---- updating/ upgrading..."
echo "               -- updating apt packages..."
sudo apt update &>/dev/null \
&& echo "               -- upgrading apt packages..." \
&& sudo apt upgrade -y &>/dev/null \
&& echo "       ---- finished: apt packages updated/ upgraded."

# Clean up potentially interupted packages:
echo "          ---- making sure packages finished installing..."
echo "               -- running dpkg configure..."
sudo dpkg --configure -a &>/dev/null \
&& echo "          ---- finished install check..."

# Finishing up:
cd /home/vagrant
echo " -------- FINISHED: apt package maintenance complete."