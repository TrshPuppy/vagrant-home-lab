#!/bin/bash

# Banner:
echo " -------- STARTING CONFIGURE.SH"
echo "          ---- copying config files to home dir..."
echo "               -- ensuring ownership of config files..."
echo "               -- moving files..."
configs_list=$(ls -a /tmp/vagrant/shared-configs)

for file in $configs_list; do
	if [[ $file == '.' ]]; then
		continue
	elif [[ $file == '..' ]]; then
		continue
	else
		echo " 				    - current file is $file"
		cp /tmp/vagrant/shared-configs/$file /home/vagrant/$file \
		&& chown vagrant:vagrant /home/vagrant/$file \
		&& chmod 755 /home/vagrant/$file
	fi
done
echo " 		    ---- config files moved"
echo " -------- FINISHED."
