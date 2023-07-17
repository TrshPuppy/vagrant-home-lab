#!/bin/bash

# Banner:
echo "          ---------------------------------------------------> "
echo "                           STARTING INSTALL_GOLANG.SH <------- "

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
#     # Install using current version
#     echo "                             fetching tarball... ----"
#     wget "https://golang.org/dl/$current_go_version.linux-amd64.tar.gz" & wait
# }

# extract_tarball(){
#     echo "                           extracting tarball... ----"    
#     #sudo rm -rf /home/$user/gocode/go/
#     tar -C /home/$user/gocode -xzf "$current_go_version.linux-amd64.tar.gz"
# }

# update_environment(){
#     echo "                         updating environment... ----"      
#     echo "PATH=\$PATH:/home/$user/gocode/go/bin" >> "/home/$user/.profile"

#     cd /home/$user
#     echo "                         sourcing .profile... --"
#     source .profile
# }

# clean_up(){
#     echo "                                  cleaning up... ----"
#     rm "/home/$user/gocode/$current_go_version.linux-amd64.tar.gz"
# }

# verify_install(){
#     echo "                       verifying installation... ----"

#     declare -i post_install=$(go version 2>/dev/null | grep -c 'go')
#     if [[ $post_install -eq 1 ]]; then 
#         echo '                   go successfully installed. --'
#     else
#         echo '                        go failed to install. --'
#     fi
# }

# # Start
# echo "                              checking for go... ----"
# if [[ $go_present -eq 0 ]]; then
#     echo '              go not installed. Continuing... --'
#      install_go & wait
#      extract_tarball
#      update_environment 
#      clean_up 
#      verify_install
# else
#     echo '            go already installed. Skipping... --'
# fi

echo "                                            FINISHED. --------"
echo "          ---------------------------------------------------> "