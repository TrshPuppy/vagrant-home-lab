#!/bin/bash

# Banner:
echo " -------- STARTING INSTALL_TOOLS.SH"
cd /home/vagrant

# Some gobals:
configs_path="/tmp/vagrant/configs"
user=$(cat $configs_path/box_env.txt | grep "user" | cut -d ":" -f 2 | tr -d '\r')
shell=$(cat $configs_path/box_env.txt | grep "shell" | cut -d ":" -f 2 | tr -d '\r')
shared_tools=$(cat $configs_path/unique_tools.txt)

declare -i tools_installed=0
declare -i install_scripts_ran=0

check_for_apt_package(){
	# $1 is our package to check:
	echo "               -- checking that $1 doesn't already exist"
	declare -i check_func=$(sudo apt list --installed 2>/dev/null | grep -c "^$1/")
	
	if [[ $check_func -eq 0 ]]; then
		installed=0
		echo "                  - $1 not found, installing..."
	else
		installed=1
		echo "                  - $1 already installed, skipping."
	fi
	return $installed
}

install_apt_package(){
	#echo "			     -- install function."
	sudo apt install $1 -y 2>/dev/null
	tools_installed+=1
}

# We should correct our install context so it is the user's
cd /home/$user
source .profile

echo "          ---- checking tools in shared_tools.txt..."
for row in $shared_tools; do
	tool=$(echo $row | cut -d ":" -f 1)
	technique=$(echo $row | cut -d ":" -f 2 | tr -d '\r')

	if [[ $technique == 'apt' ]]; then	
		# Check for tool:
		check_for_apt_package $tool
		tool_present=$?

		if [[ $tool_present -eq 0 ]]; then
			install_apt_package $tool
			tools_installed+=1
		else
		continue
		fi
	else
		echo "          ---- calling install script for $tool..."
		$target_shell $technique $target_user
		install_scripts_ran+=1
	fi
done

# Finishing up:
cd /home/vagrant
echo -e " -------- FINISHED: $tools_installed tools installed via apt" 
echo -e "          --------: $install_scripts_ran install script(s) ran (check output for success)."



# #!/bin/bash

# 		# NOTES FOR ME:
# 		# 	automate this so it can take a list and install each tool in list
# 		#	add function from kali box which checks if tool is already installed
# 		# 	add tool installed counter
# 		#	add cd /home/vagrant  to start and  end?

# # Banner:
# echo " -------- STARTING INSTALL_TOOLS.SH"
# cd /home/vagrant

# # Some globals:
# user="devpuppy"
# user_home="/home/$user"

# declare -i tools_installed=0
# tools_to_install=("ubuntu-desktop" 
# 				  "firefox" 
# 				  "software-properties-common" 
# 				  "apt-transport-https")

# pain_in_ass_tools=(handle_vs_code)
	
# # Some useful little functions:
# check_for_apt_package(){
# 	# $1 is our package to check:
# 	check_func=$(apt list --installed 2>/dev/null | grep -c "^$1/")
# 	echo "               -- checking that $1 doesn't already exist"
	
# 	if [[ $check_func -eq 0 ]]; then # If this breaks change '$check_func' back to 'check_func'
# 		installed=0
# 		echo "               -- $1 not found, installing..."
# 	else
# 		installed=1
# 		echo "               -- $1 already installed, skipping."
# 	fi
# return $installed
# }

# install_apt_package(){
# 	sudo apt install $1 -y 2>/dev/null
# }

# handle_vs_code(){
# 	# should prbably switch to created user
# 	target_package="code"

# 	# check for vscode:
# 	check_for_apt_package $target_package
# 	result_vs=$?

# 	if [[ $result_vs -eq 0 ]]; then
# 		# From this resource: https://code.visualstudio.com/docs/setup/linux#_installation
# 		sudo apt-get install wget gpg
# 		wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
# 		sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
# 		sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
# 		rm -f packages.microsoft.gpg

# 		sudo apt update
# 		sudo apt install code 2>/dev/null
# 		tools_installed+=1
# 	fi	
# }

# echo "          ---- installing tools..."
# cd $user_home

# for t in ${tools_to_install[@]}; do
# 	# Check for tool:
# 	check_for_apt_package $t
# 	result_t=$?

# 	if [[ $result_t -eq 0 ]]; then
# 		install_apt_package $t
# 		tools_installed+=1
# 	else
# 		continue
# 	fi
# done

# echo "          ---- installing pain in ass tools..."
# for pa in ${pain_in_ass_tools[@]}; do
# 	"$pa"
# done

# #  Finish up:
# echo " -------- FINISHED: $tools_installed new tools installed."

