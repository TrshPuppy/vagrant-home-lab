#!/bin/bash

# Add banner so we can tell what's happening:
echo "/ ******************************* STARTING CONFIGURE.SH ******************************* \\"
cd /home/vagrant

# Some nice globals:
	user="hakcypuppy"
#	user_pass=$(cat /home/vagrant/configs/pass.txt)
	user_pass=$(cat /tmp/vagrant/configs/pass.txt |  mkpasswd --stdin)
	user_home="/home/$user"

# Make a new user:i
echo ":                                  Adding user                                    :"
	# Make sure the user doesn't exist:
	if cat "/etc/passwd" | grep -c $user; then
		echo "user $user already exists...skipping..."
	else
		sudo useradd -m -p $user_pass -s /bin/bash $user
	fi

echo ":                               Adding to sudo Group                              :"
	sudo usermod -a -G sudo $user

# Something about delete password file
echo ":                                Removing pass file                               :"
#	sudo rm /home/vagrant/configs/pass.txt
	sudo rm /tmp/vagrant/configs/pass.txt

# Load Vim config from /configs:
echo ":                                 Configuring Vim                                 :"
	echo ":                          adding files and dirs...                           :"
	cd $user_home
	mkdir .vim
	mkdir .vim/autoload
	mkdir .vim/backup
	mkdir .vim/colors
	mkdir .vim/plugged

	echo ":                           copying over .vimrc...                            :"
#	sudo cp /home/vagrant/shared-configs/.vimrc $user_home/.vimrc
	sudo cp /tmp/vagrant/shared-configs/.vimrc $user_home/.vimrc

# Finishing up:
cd /home/vagrant
