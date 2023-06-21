#!/bin/bash

		# NOTES FOR ME:
		# 	automate this so it can take a list and install each tool in list
		#	add function from kali box which checks if tool is already installed
		# 	add tool installed counter
		#	add cd /home/vagrant  to start and  end?

# Banner:
echo "                        -------- STARTING INSTALL_TOOLS.SH"
cd /home/vagrant

# Some globals:
declare -i tools_installed=0
tools_to_install=("--no install recommends ubuntu-desktop" 
					"firefox" 
					"software-properties-common" 
					"apt-transport-https")

pain_in_ass_tools=(handle_vs_code)
	
# Some useful little functions:
check_for_apt_package(){
	# $1 is our package to check:
	echo "                                          -- checking that $1 doesn't already exist"
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

handle_vs_code(){
	# should prbably switch to created user
	target_package="code"

	# check for vscode:
	check_for_apt_package $target_package
	result_vs=$?

	if [[ $result_vs -eq 0 ]]; then
		sudo apt-get install -y wget gpg
		wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
		sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
		sudo sh -c 'echo "deb [arch=amd64, arm64, armhf, signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
		rm -f packages.microsoft.gpg
		tools_installed+=1
	fi	
}

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

echo "                                 ---- installing pain in ass tools..."
for pa in ${pain_in_ass_tools[@]}; do
	"$pa"
done

#  Finish up:
echo "                        -------- FINISHED: $tools_installed new tools installed."

# # Add banner so we can tell what's happening:
# echo "                        ---------- STARTING INSTALL_TOOLS.SH ----------"

# # Ubuntu specific tools:
# 	# A GUI:
# echo "                                       installing desktop env..."
# 	sudo apt install -y --no-install-recommends ubuntu-desktop

# 	# Firefox:
# echo "                                       installing Firefox..."
# 	sudo apt install -y firefox

# 	# VS Code:
# echo "                                       installing VS Code..."
# 	sudo apt install -y software-properties-common
# 	sudo apt install -y apt-transporrt-https

# 	sudo apt-get install -y wget gpg
# 	wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
# 	sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
# 	sudo sh -c 'echo "deb [arch=amd64, arm64, armhf, signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
# 	rm -f packages.microsoft.gpg

# #  Finish up:
# echo "                                     Finished: <number> new tools installed."
