#!/bin/zsh

# Banner:
echo "                         ---------- STARTING INSTALL_TOOLS.SH"
cd /home/vagrant

# Some globals:
declare -i tools_installed=0
tools_to_install=("git" "vim")
	
# Some useful little functions:
check_for_apt_package(){
	# $1 is our package to check:
	echo "                                             -- checking that $1 doesn't already exist"
	if dpkg -s "$1" | grep -q "*not installed"; then
		installed=0
		echo "                                         -- $1 not found, installing..."
	else
		installed=1
        echo "                                         -- $1 already installed, skipping."
	fi
return $installed
}

install_apt_package(){
	sudo apt install $1 -y	
}

echo "                                    ---- installing tools..."
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
echo "                        ---------- FINISHED: $tools_installed tools installed"
