#!/bin/zsh

# Banner:
echo "                        -------- STARTING INSTALL_TOOLS.SH"
cd /home/vagrant

# Some globals:
user="hakcypuppy"
user_home="/home/$user"

declare -i tools_installed=0
tools_to_install=("git" "vim")
pain_in_ass_tools=()
	
# Some useful little functions:
# check_for_apt_package(){
# 	# $1 is our package to check:
# 	check_func=$(apt list --installed | grep -c $1)
# 	echo "                                      -- checking that $1 doesn't already exist"
# 	if [[ check_func -eq 0 ]]; then
# 		installed=0
# 		echo "                                      -- $1 not found, installing..."
# 	else
# 		installed=1
#         echo "                                      -- $1 already installed, skipping."
# 	fi
# return $installed
# }

check_for_apt_package(){
	# $1 is our package to check:
	check_func=$(apt list --installed 2>/dev/null | grep -c "^$1/")
	echo "                                      -- checking that $1 doesn't already exist"
	if [[ check_func -eq 0 ]]; then
		installed=0
		echo "                                      -- $1 not found, installing..."
	else
		installed=1
        echo "                                      -- $1 already installed, skipping."
	fi
return $installed
}

install_apt_package(){
	sudo apt install $1 -y 2>dev/null	
}

echo "                                 ---- installing tools..."
cd $user_home

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

# Finishing up:
cd /home/vagrant
echo "                        -------- FINISHED: $tools_installed tools installed"
