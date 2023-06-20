#!/bin/bash

# Add banner so we can tell what's happening:
echo "                        ---------- STARTING CONFIGURE.SH ----------"

# Some globals:
VM_CONFIGS_DIR="/home/vagrant/configs"
VM_SHARED_CONFIGS_DIR="/home/vagrant/shared-configs"

# Load Vim config from /configs
echo "                                      creating vim env..."
	cd ~
	mkdir .vim
	mkdir .vim/autoload
	mkdir .vim/backup
	mkdir .vim/colors
	mkdir .vim/plugged

echo "                                      copying over .vimrc..."
	sudo cp $VM_SHARED_CONFIGS_DIR/.vimrc /home/vagrant/.vimrc

echo "                                   Finished."
