#!bin/zsh

# Banner:
echo " -------- STARTING MAINTENANCE.SH"
cd /home/vagrant

# Cuz I'm queen of making shit complicated, find out who our user is from a safe starting point:
target_user=$(cat /etc/passwd | grep "puppy" | cut -d ":" -f 1)

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
