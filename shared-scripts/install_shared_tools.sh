#!/bin/bash

# Banner:
echo " -------- STARTING INSTALL_SHARED_TOOLS.SH"
cd /home/vagrant
source .profile

# Some gobals:
configs_path="/tmp/vagrant/configs"
# user=$(cat $configs_path/box_env.txt | grep "user" | cut -d ":" -f 2 | tr -d '\r')
# shell=$(cat $configs_path/box_env.txt | grep "shell" | cut -d ":" -f 2 | tr -d '\r')
shared_tools=$(cat $configs_path/shared_tools.txt)

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
	sudo apt install $1 -y 2>/dev/null
	tools_installed+=1
}

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
		$target_shell "/tmp/vagrant/shared-scripts/$technique" $target_user
		install_scripts_ran+=1
	fi
done

# Finishing up:
cd /home/vagrant
echo -e " -------- FINISHED: $tools_installed tools installed via apt" 
echo -e "          --------: $install_scripts_ran install script(s) ran (check output for success)."
