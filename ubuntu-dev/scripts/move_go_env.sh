#!/bin/bash

# Banner:
echo " -------- STARTING MOVE_GO_ENV.SH"
cd /home/vagrant

# Some globals:
configs_path="/tmp/vagrant/configs"
user=$(cat $configs_path/box_env.txt | grep "user" | cut -d ":" -f 2 | tr -d '\r')
current_go_dir=/home/$user/gocode
target_go_dir=/home/$user/tun/gocode
declare -i profile_path_is_correct=0
declare -i go_dir_is_correct=0
declare -i error_count=0

check_profile_path(){
    declare -i path_correct=$(cat /home/$user/.profile | grep -c "PATH=\$PATH:$target_go_dir/go/bin")
    if [[ $path_correct -eq 0 ]]; then
        echo "               -- path in profile is not correct"
        profile_path_is_correct=0
    else
        echo "               -- path in profile is correct."
        profile_path_is_correct=1
    fi
}

check_go_dir(){
    declare -i dir_correct=$(ls $target_go_dir | grep -c "go")
    if [[ $dir_correct -eq 0 ]]; then
        echo "               -- dir is not correct"
    go_dir_is_correct=0
    else
        echo "               -- dir is correct."
    go_dir_is_correct=1
    fi
}

fix_go_dir(){
    echo "               -- checking that go is actually present in /home/$user/gocode..."
    declare -i go_is_present=$(ls $current_go_dir | grep -c "go")

    if [[ $go_is_present -eq 0 ]]; then
        echo "                  - go may not even be present, exiting..."
        error_count+=1
        return
    else
        echo "                  - go is present, continuing..."
        echo "               -- moving go dir."
        sudo mv $current_go_dir $target_go_dir
    fi
}

fix_path_in_profile(){
    echo "               -- fixing go path in .profile..."
    echo "PATH=\$PATH:$target_go_dir/go/bin" >> "/home/$user/.profile"
}

echo "          ---- checking for target go dir..."
check_go_dir

echo "          ---- checking for correct path in source."
check_profile_path

if [[ $go_dir_is_correct -eq 0 ]]; then
    echo "          ---- fixing go dir..."
    fix_go_dir & wait
    echo "               -- checking for fixed go dir..."
    check_go_dir
fi

if [[ $profile_path_is_correct -eq 0 ]]; then
    echo "          ---- fixing path in .profile..."
    fix_path_in_profile & wait
    echo "               -- checking for fixed path..."
    check_profile_path
fi

# Check again after attempted fixes:
if [[ $go_dir_is_correct -eq 0 ]]; then
    echo "          ---- go dir still incorrect, exiting..."
    error_count+=1    
fi

if [[ $profile_path_is_correct -eq 0 ]]; then
    echo "          ---- profil path still incorrect, exiting..."
    error_count+=1 
fi

echo " -------- FINISHED: exiting with $error_count Errors."