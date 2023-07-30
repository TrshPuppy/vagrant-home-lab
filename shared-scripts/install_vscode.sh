#!/bin/bash

# Banner:
echo "          ---------------------------------------------------> "
echo "                           STARTING INSTALL_VSCODE.SH <------- "

configs_path="/tmp/vagrant/configs"
cd /home/vagrant
source .profile

check_for_apt_package(){
	# $1 is our package to check:
	declare -i check_func=$(apt list --installed 2>/dev/null | grep -c "^$1/")
	
	if [[ $check_func -eq 0 ]]; then
		installed=0
	else
		installed=1
	fi
return $installed
}

handle_vs_code(){
    echo "                         installing vscode... --"
    # From this resource: https://code.visualstudio.com/docs/setup/linux#_installation
    sudo apt-get install wget gpg
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg \
    && sudo install -D -o vagrant -g vagrant -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg \
    && sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list' \
    && rm -f packages.microsoft.gpg

    sudo apt update 2>/dev/null \
    && sudo apt install code 2>/dev/null
}

echo "                          checking for vscode... ----"
check_for_apt_package "code"
code_present=$?

if [[ $code_present -eq 0 ]]; then
    echo "          vscode not installed. Continuing... --"
    handle_vs_code
else
    echo "        vscode already installed. Skipping... --"
fi

cd /home/vagrant
echo "                                            FINISHED. --------"
echo "          ---------------------------------------------------> "






























# # Make sure we're in the right place/ context:
# configs_path="/tmp/vagrant/configs"
# user=$(cat $configs_path/box_env.txt | grep "user" | cut -d ":" -f 2 | tr -d '\r')
# shell=$(cat $configs_path/box_env.txt | grep "shell" | cut -d ":" -f 2 | tr -d '\r')
# cd /home/$user
# source .profile

# # Some globals:
# declare -i go_present=$(go version 2>/dev/null | grep -c 'go')
# version_req=$(curl -sSL "https://golang.org/dl/?mode=json")
# current_go_version=$(echo "$version_req" | grep "go" | cut -d "\"" -f 4 | head -n 1)

# install_go(){
#     # Install using current version:
#     echo "                             fetching tarball... ----"
#     wget "https://golang.org/dl/$current_go_version.linux-amd64.tar.gz" >/dev/null
# }

# extract_tarball(){
#     echo "                           extracting tarball... ----"    
#     sudo rm -rf /usr/local/go && \
#     tar -C /usr/local -xzf "$current_go_version.linux-amd64.tar.gz"
# }

# update_environment(){
#     echo "                         updating environment... ----"      
#     echo "PATH=\$PATH:/usr/local/go/bin" >> "/home/$user/.profile"

#     cd /home/$user
#     echo "                         sourcing .profile... --"
#     source .profile
# }

# clean_up(){
#     echo "                                  cleaning up... ----"
#     rm "$current_go_version.linux-amd64.tar.gz"
# }

# verify_install(){
#     echo "                       verifying installation... ----"

#     declare -i post_install=$(go version 2>/dev/null | grep -c 'go')
#     if [[ $post_install -eq 1 ]]; then 
#         echo "                   go successfully installed. --"
#     else
#         echo "                        go failed to install. --"
#     fi
# }

# # Start
# echo "                              checking for go... ----"
# if [[ $go_present -eq 0 ]]; then
#     echo "              go not installed. Continuing... --"
#      install_go
#      extract_tarball
#      update_environment 
#      clean_up 
#      verify_install
# else
#     echo "            go already installed. Skipping... --"
# fi

echo "                                            FINISHED. --------"