#!/bin/zsh
# This script should be run after all other provisioning scripts to ensure the other scripts were successful:

# Banner:
echo " -------- RUNNING TESTS"
cd /home/vagrant

# Some globals:
configs_path="/tmp/vagrant/configs"
user=$(cat $configs_path/box_env.txt | grep "user" | cut -d ":" -f 2 | tr -d '\r')
shell=$(cat $configs_path/box_env.txt | grep "shell" | cut -d ":" -f 2 | tr -d '\r')
shared_tools=$(cat $configs_path/unique_tools.txt)
declare -i error_count=0

cd /home/$user
source .profile

# user="devpuppy"
# user_home="/home/$user"

vag_user="vagrant"
vag_home="/home/vagrant"

user_home_files=(".vimrc")
# installed_tools=("git" 
# 				 "vim" 
# 				 "code" 
# 				 "ubuntu-desktop" 
# 				 "firefox" 
# 				 "software-properties-common" 
# 				 "apt-transport-https")
shared_tools=$(cat $configs_path/shared_tools.txt)
unique_tools=$(cat $configs_path/unique_tools.txt)

check_tools(){
	# $1 should be tool
	# $2 should be technique
	# $3 is the current row
	if [[ $2 == 'apt' ]]; then	
		# Check for tool:
		declare -i t_exists=$(apt list --installed 2>/dev/null | grep -c "^$1/")
		
		if [[ $t_exists -eq 0 ]]; then
			echo "                  - ERROR: tool $1 was not installed"
	 		error_count+=1	
		else
			echo "                  - tool $1 exists"
		fi
	else
		command=$(echo $3 | cut -d ":" -f 4 | tr -d '\r')
		g_rep=$(echo $3 | cut -d ":" -f 3 | tr -d '\r')
		declare -i pain_in_ass_t_exists=$($1 $command 2>/dev/null | grep -c $g_rep)
		
		if [[ $pain_in_ass_t_exists -eq 0 ]]; then
			echo "                  - ERROR: tool $1 was not installed"
			echo "     TOOL: $1"
			echo "     GREP: $g_rep"
			echo "     COMMAND: $command"
			echo "     PAT:    $pain_in_ass_t_exists"
	 		error_count+=1	
		else
			echo "                  - tool $1 exists"
		fi
	fi
}

# Check for user and user directories:
echo "          ---- checking for user config..."
target_user=$(sudo cat /etc/passwd | grep $user -c)

if [[ $target_user -eq 1 ]]; then
	echo "               -- user $user exists in /etc/passwd"
	user_exists=true
else
	echo "               -- ERROR: missing user $user in /etc/passwd"
	user_exists=false
	error_count+=1
fi

# Check that user is in sudo group:
echo "          ---- checking user is sudo..."
if [[ "$user_exists" == "true" ]]; then
	exists_in_sudoers=$(cat /etc/group | grep "sudo" | grep $user -c)

	if [[ $exists_in_sudoers -eq 1 ]]; then
		echo "               -- user $user is part of sudo group"
	else
		echo "               -- ERROR: user $user is not part of sudo group"
		error_count+=1	
	fi
fi

# Check for config files in user home dir:
echo "          ---- checking for config  files in user home..."
if [[ "$user_exists" == "true" ]]; then
	for f in ${user_home_files[@]}; do
		f_exists=$(ls -a $user_home | grep $f -c)

		if [[ $f_exists -eq 1 ]]; then
			echo "               -- cofig file $f exists"
			continue
		else
			echo "               -- ERROR: file $f is not present in $user_home"
			error_count+=1	
		fi
	done
fi

# Check that tools were installed:	
echo "          ---- checking that tools installed successfully..."

# Check shared tools:
echo "               -- checking shared tools..."
for row in $shared_tools; do
	tool=$(echo $row | cut -d ":" -f 1)
	technique=$(echo $row | cut -d ":" -f 2 | tr -d '\r')

	check_tools $tool $technique $row
done

# Check unique tools:
echo "               -- checking unique tools..."
for row in $unique_tools; do
	tool=$(echo $row | cut -d ":" -f 1)
	technique=$(echo $row | cut -d ":" -f 2 | tr -d '\r')

	check_tools $tool $technique $row
done



# for t in ${installed_tools[@]}; do
# 	# t_exists=$(dpkg -s $t | grep "install ok installed" -c)
# 	t_exists=$(apt list --installed 2>/dev/null | grep -c "^$t/")

# 	if [[ $t_exists -eq 0 ]]; then
# 		echo "               -- ERROR: tool $t was not installed"
# 		error_count+=1	
# 	else
# 		echo "               -- tool $t exists"
# 		continue
# 	fi
# done

# Check unique tools:

# Check vagrant home directory:
	# eh.... mayber later

echo "          ---- checking for deleted passy.txt"
# Check that pass was deleted:
p_exists=$(ls /tmp/vagrant/shared-configs | grep "passy.txt" -c)

if [[ $p_exists -eq 1 ]]; then
	echo "               -- ERROR:  passy.txt not deleted from /tmp/vagrant/configs"
	error_count+=1
else
	echo "               -- passy.txt successfully deleted"
fi
	
# Finishing up:
cd /home/vagrant
echo " -------- FINISHED: exiting Tests w/ $error_count Errors"
