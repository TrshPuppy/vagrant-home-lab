#!/bin/bash

# Banner:
echo " -------- STARTING INSTALL_SHARED_TOOLS.SH"

configs_path="/tmp/vagrant/configs"
user=$(cat $configs_path/box_env.txt | grep "user" | cut -d ":" -f 2 | tr -d '\r')
echo "user= $user"
shell=$(cat $configs_path/box_env.txt | grep "shell" | cut -d ":" -f 2 | tr -d '\r')
echo "shell= $shell"
declare -i tools_installed=0
declare -i install_scripts_ran=0

shared_tools=$(cat $configs_path/shared_tools.txt)

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

# Source profile
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
echo -e "          --------: & $install_scripts_ran install script(s) ran (check output for success)."


# # Banner:
# echo " -------- STARTING INSTALL_SHARED_TOOLS.SH"
# cd /home/vagrant

# # Some globals:
# declare -i tools_installed=0
# # Cuz I'm queen of making shit complicated, find out who our user is from a safe starting point:
# target_user=$(cat /etc/passwd | grep "puppy" | cut -d ":" -f 1)
# target_shell=$(echo $SHELL | cut -d "/" -f 3)
# tools_to_install=("git" "vim")

# pain_in_ass_tools=(handle_golang)
	
# # Some useful little functions:
# check_for_apt_package(){
# 	# $1 is our package to check:
# 	check_func=$(apt list --installed 2>/dev/null | grep -c "^$1/")
# 	echo "               -- checking that $1 doesn't already exist"
# 	if [[ check_func -eq 0 ]]; then
# 		installed=0
# 		echo "               -- $1 not found, installing..."
# 	else
# 		installed=1
# 		echo "               -- $1 already installed, skipping."
# 	fi
# return $installed
# }
# # check_for_apt_package(){
# # 	# $1 is our package to check:
# # 	echo "                                      -- checking that $1 doesn't already exist"
# # 	if dpkg -s "$1" | grep -q "*not installed"; then
# # 		installed=0
# # 		echo "                                      -- $1 not found, installing..."
# # 	else
# # 		installed=1
# # 		echo "                                      -- $1 already installed, skipping."
# # 	fi
# # return $installed
# # }

# install_apt_package(){
# 	sudo apt install $1 -y	
# }

# handle_golang(){
# 	echo "               -- installing golang..."                           
# 	$target_shell /tmp/vagrant/shared-scripts/install_golang.sh $target_user
# }

# cd /home/"$target_user"
# echo "          ---- installing tools..."
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

# # Finishing up:
# cd /home/vagrant
# echo " -------- FINISHED: $tools_installed new tools installed."

