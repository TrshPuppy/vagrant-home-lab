#!/bin/bash

# Banner:
echo " -------- STARTING CONFIGURE.SH"
echo "          ---- copying config files to home dir..."
echo "               -- ensuring ownership of config files..."
echo "               -- moving files..."
configs_list=$(ls -a /tmp/vagrant/shared-configs)

for file in $configs_list; do
	if [[ $file == '.' ]]; then
		continue
	elif [[ $file == '..' ]]; then
		continue
	else
echo " 				    - current file is $file"
		cp /tmp/vagrant/shared-configs/$file /home/vagrant/$file \
		&& chown vagrant:vagrant /home/vagrant/$file \
		&& chmod 755 /home/vagrant/$file
	fi
done
echo " 		    ---- config files moved"
echo " -------- FINISHED."








# cd /home/vagrant

# # Make a new user:
# echo "          ---- adding user..."
# # Make sure the user doesn't exist:
# declare -i check_for_user=$(cat /etc/passwd | grep -c $user)

# if [[ $check_for_user -eq 1 ]]; then
# 	echo "               -- user $user already exists...skipping..."
# else
# 	sudo useradd -m -p $user_pass -s /bin/bash $user
# 	echo "               -- user $user created"	
# fi

# # Add user to sudo group:
# echo "          ---- adding to sudo group..."
# sudo usermod -a -G sudo $user

# echo "          ---- adding to vboxsf group..."
# sudo usermod -a -G vboxsf $user

# # Remove password file:
# echo "               -- removing pass file..."
# sudo rm /tmp/vagrant/shared-configs/passy.txt
# echo "          ---- finished: new user added"

# # Load Vim config from /configs:
# echo "          ---- configuring vim..."
# # Check if already present:
# if [[ $(ls /home/$user -a | grep ".vimrc" -c) -eq 1 ]]; then
# 	echo "               -- vim already configured, skipping,.."
# else
# 	echo "               -- adding files and dirs..."
# 	cd $user_home
# 	mkdir .vim
# 	mkdir .vim/autoload
# 	mkdir .vim/backup
# 	mkdir .vim/colors
# 	mkdir .vim/plugged

# 	echo "               -- adding vim configuration file..."
# 	sudo cp /tmp/vagrant/shared-configs/.vimrc $user_home/.vimrc
# fi
# echo "          ---- finished: vim installed and configured"

# # Finishing up:
# cd /home/vagrant


