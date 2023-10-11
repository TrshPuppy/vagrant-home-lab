#!/bin/bash

# Banner:
echo "          ---------------------------------------------------> "
echo "                           STARTING INSTALL_GOLANG.SH <------- "

# Make sure we're in the right place/ context:
configs_path="/tmp/vagrant/configs"
# user=$(cat $configs_path/box_env.txt | grep "user" | cut -d ":" -f 2 | tr -d '\r')
# shell=$(cat $configs_path/box_env.txt | grep "shell" | cut -d ":" -f 2 | tr -d '\r')

cd /home/vagrant
source .profile

# Some globals:
declare -i go_present=$(go version 2>/dev/null | grep -c 'go')
version_req=$(curl -sSL "https://golang.org/dl/?mode=json")
current_go_version=$(echo "$version_req" | grep "go" | cut -d "\"" -f 4 | head -n 1)
go_install_path="/home/vagrant/go"
go_path="/home/vagrant/repos"
go_root="/home/vagrant/go/go"

install_go(){
    # Install using current version
    echo "                              creating go dir... ----"
    mkdir $go_install_path
    cd $go_install_path
    echo "                             fetching tarball... ----"
    wget "https://golang.org/dl/$current_go_version.linux-amd64.tar.gz" \
    && return
}

extract_tarball(){
    echo "                           extracting tarball... ----"    
    sudo rm -rf $go_install_path/go \
    && tar -C $go_install_path -xzf "$current_go_version.linux-amd64.tar.gz" \
    && return
}

update_environment(){
    echo "                         updating environment... ----"
    echo "GOROOT=$go_root" >> "/home/vagrant/.profile" \
    && echo "GOPATH=$go_path" >> "/home/vagrant/.profile" \
    && echo "PATH=\$PATH:$go_root/bin:$go_path" >> "/home/vagrant/.profile"

    cd /home/vagrant
    echo "                         sourcing .profile... --"
    source .profile \
    && return
}

clean_up(){
    echo "                                  cleaning up... ----"
    rm "$go_install_path/$current_go_version.linux-amd64.tar.gz" \
    && return
}

verify_install(){
    echo "                       verifying installation... ----"

    declare -i post_install=$(go version 2>/dev/null | grep -c 'go')
    if [[ $post_install -eq 1 ]]; then 
        echo '                   go successfully installed. --'
    else
        echo '                        go failed to install. --'
    fi
    return
}

# Start
echo "                              checking for go... ----"
if [[ $go_present -eq 0 ]]; then
    echo '              go not installed. Continuing... --'
    install_go \
    && extract_tarball \
    && update_environment \
    && clean_up \
    && verify_install
else
    echo '            go already installed. Skipping... --'
fi

echo "                                            FINISHED. --------"
echo "          ---------------------------------------------------> "