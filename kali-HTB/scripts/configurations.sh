!#/bin/bash

# Load Vim config from /configs
	echo "configuring vim..."
	cd ~
	mkdir .vim
	mkdir .vim/autoload
	mkdir .vim/backup
	mkdir .vim/colors
	mkdir .vim/plugged

	echo "Copying over .vimrc..."
	sudo cp ~/home/vagrant/configs/.vimrc ~.vimrc

