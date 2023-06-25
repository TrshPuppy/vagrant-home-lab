#!/bin/bash

echo "golang"

# # Banner:
# echo "                  -------- STARTING INSTALL_GOLANG.SH"

# # Make sure we're in the right place:
# #       Also this is probably not secure...
# target_user=$1
# cd "/home/$target_user"
# source .profile

# # Some globals:
# declare -i go_present=$(go version 2>/dev/null | grep -c 'go')
# version_req=$(curl -sSL "https://golang.org/dl/?mode=json")
# current_go_version=$(echo "$version_req" | grep "go" | cut -d "\"" -f 4 | head -n 1)

# install_go(){
#     # Install using current version:
#     echo "                           ---- fetching tarball..."
#     wget "https://golang.org/dl/$current_go_version.linux-amd64.tar.gz" >/dev/null
# }

# extract_tarball(){
#     echo "                           ---- extracting tarball..."
#     sudo rm -rf /usr/local/go && \
#     tar -C /usr/local -xzf "$current_go_version.linux-amd64.tar.gz"
# }

# update_environment(){
#     echo "                           ---- updating environment..."
#     echo "PATH=\$PATH:/usr/local/go/bin" >> "/home/$target_user/.profile"

#     cd /home/$target_user
#     echo "                                -- sourcing .profile..."
#     source .profile
# }

# clean_up(){
#     echo "                           ---- cleaning up..."
#     rm "$current_go_version.linux-amd64.tar.gz"
# }

# verify_install(){
#     echo "                           ---- verifying installation..."

#     declare -i post_install=$(go version 2>/dev/null | grep -c 'go')
#     if [[ $post_install -eq 1 ]]; then 
#         echo "                                -- go successfully installed."
#     else
#         echo "                                -- go failed to install."
#     fi
# }

# # Start
# echo "                           ---- checking for go..."
# if [[ $go_present -eq 0 ]]; then
#      echo "                                -- go not installed. Continuing..."
#      install_go
#      extract_tarball
#      update_environment 
#      clean_up 
#      verify_install
# else
#     echo "                                -- go already installed. Skipping..."
# fi

# echo "                  -------- FINISHED."