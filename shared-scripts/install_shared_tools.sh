#!/bin/zsh

# Banner:
echo "                        -------- STARTING INSTALL_SHARED_TOOLS.SH"
cd /home/vagrant

# Some globals:
declare -i tools_installed=0
# Cuz I'm queen of making shit complicated, find out who our user is from a safe starting point:
target_user=$(cat /etc/passwd | grep "puppy" | cut -d ":" -f 1)
tools_to_install=("git" "vim")
	
# Some useful little functions:
check_for_apt_package(){
	# $1 is our package to check:
	echo "                                      -- checking that $1 doesn't already exist"
	if dpkg -s "$1" | grep -q "*not installed"; then
		installed=0
		echo "                                      -- $1 not found, installing..."
	else
		installed=1
		echo "                                      -- $1 already installed, skipping."
	fi
return $installed
}

install_apt_package(){
	sudo apt install $1 -y	
}

cd /home/"$target_user"
echo "                                 ---- installing tools..."
for t in ${tools_to_install[@]}; do
	# Check for tool:
	check_for_apt_package $t
	result_t=$?

	if [[ $result_t -eq 0 ]]; then
		install_apt_package $t
		tools_installed+=1
	else
		continue
	fi
done

# Finishing up:
cd /home/vagrant
echo "                        -------- FINISHED: $tools_installed new tools installed."


# echo "                                       installing git..."
# 	# Install git:
# 		# Check for git:
# 		check_for_apt_package "git"
# 		result_git=$?

# 	if [[ $result_git -eq 0 ]]; then
# 		sudo apt install git -yi
# 		tools_installed+=1
# 	else
# 		echo "                                           git already installed"
# 	fi

# echo "                                       installing vim..."
# 	# Install Vim:
# 		# Check for vim:
# 		check_for_apt_package "vim"
# 		result=$?

# 	if [[ $result -eq 0 ]]; then
# 		echo "                                           vim not found, installing..."
# 		sudo apt install vim -y
# 		tools_installed+=1
# 	else
# 		echo "                                           vim already installed"
# 	fi

# echo "                                    Finished: $tools_installed new tools installed."
# # Finishing up:
# cd /home/vagrant
