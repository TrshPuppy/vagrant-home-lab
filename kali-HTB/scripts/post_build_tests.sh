#!/bin/bash

# This script should be run after all other provisioning scripts to ensure the other scripts were successful:
cd /home/vagrant

echo ":           ---------- ---------- ---------- RUNNING TESTS ---------- ---------- ----------           :"

# Some globals:
declare -i error_count=0

user="hakcypuppy"
user_home="/home/hakcypuppy"

vag_user="vagrant"
vag_home="/home/vagrant"

user_home_files=(".vimrc")
installed_tools=("git" "vim")

# Check for user and user directories:
	echo "                                                Checking for user config"
	target_user=$(sudo cat /etc/passwd | grep $user -c)

	if [[ $target_user -eq 1 ]]; then
		echo "                                                    user $user exists in /etc/passwd"
		user_exists=true
	else
		echo "                                                    ERROR: missing user $user in /etc/passwd"
		user_exists=false
		error_count+=1
	fi

	# Check that user is in sudo group:
	if [[ "$user_exists" == "true" ]]; then
		exists_in_sudoers=$(cat /etc/group | grep "sudo" | grep $user -c)

		if [[ $exists_in_sudoers -eq 1 ]]; then
			echo "                                                    user $user is part of sudo group"
		else
			echo "                                                    ERROR: user $user is not part of sudo group"
			error_count+=1	
		fi
	fi

	# Check for config files in user home dir:
	if [[ "$user_exists" == "true" ]]; then
		for f in $user_home_files; do
			f_exists=$(ls -a $user_home | grep $f -c)

			if [[ $f_exists -eq 1 ]]; then
				echo "                                                    cofig file $f exists"
				continue
			else
				echo "                                                    ERROR: file $f is not present in $user_home"
				error_count+=1	
			fi
		done
	fi

# Check that tools were installed:
	echo "                                                Checking that tools installed"
	
	for t in $installed_tools; do
		t_exists=$(dpkg -s $t | grep "install ok installed" -c)

		if [[ $t_exists -eq 1 ]]; then
			echo "                                                    tool $t exists"
			continue
		else
			echo "                                                    ERROR: tool $t was not installed"
			error_count+=1	
		fi
	done

# Check vagrant home directory:
	# eh.... mayber later

# Check that pass was deleted:
	echo "                                                Checking for deleted pass.txt"
	p_exists=$(ls /tmp/vagrant/configs | grep "pass.txt" -c)

	if [[ $p_exists -eq 1 ]]; then
		echo "                                                    ERROR:  pass.txt not deleted from /tmp/vagrant/configs"
		error_count+=1
	else
		echo "                                                    pass.txt successfully deleted"
	fi
	
# Finishing up:
cd /home/vagrant
echo ":           ---------- --------- ---------- Exiting Tests w/ $error_count Errors ---------- ---------- ----------           "
