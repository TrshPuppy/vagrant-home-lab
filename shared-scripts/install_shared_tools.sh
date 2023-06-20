#!/bin/zsh

# Some globals:
declare -i tools_installed=0

# Add banner so we can tell what's happening:
echo "                        ---------- STARTING INSTALL_SHARED_TOOLS.SH ----------"

# Cuz I'm queen of making shit complicated, find out who our user is from a safe starting point:
	cd /home/vagrant
	target_user=$(cat /etc/passwd | grep "puppy" | cut -d ":" -f 1)
	
# Some useful little commands:
check_for_apt_package(){
	# $1 is our package to check:
	if dpkg -s "$1" | grep -q "*not installed"; then
		installed=0
	else
		installed=1
	fi
return $installed
}

cd /home/$target_user

echo "                                       installing git..."
	# Install git:
		# Check for git:
		check_for_apt_package "git"
		result_git=$?

	if [[ $result_git -eq 0 ]]; then
		echo "                                           git not found, installing..."
		sudo apt install git -yi
		tools_installed+=1
	else
		echo "                                           git already installed"
	fi

echo "                                       installing vim..."
	# Install Vim:
		# Check for vim:
		check_for_apt_package "vim"
		result=$?

	if [[ $result -eq 0 ]]; then
		echo "                                           vim not found, installing..."
		sudo apt install vim -y
		tools_installed+=1
	else
		echo "                                           vim already installed"
	fi

echo "                                    Finished: $tools_installed new tools installed."
# Finishing up:
cd /home/vagrant
