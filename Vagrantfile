# 
# -*- mode: ruby -*-
# vi: set ft=ruby :

# ------------------
#   Don't use this Vfile, it's
#   a template for the VMs which
#   live here
# ------------------

# Some variables you might want to change later:
# Vagrant:
VAGRANT_BASE = ""
VAGRANT_UPDATE = false
MOUNT_FOLDERS = false

# VirtualBox:
VBOX_NAME = ""
VBOX_MEM = ""
VBOX_CPUS = ""
VBOX_GUI = false

# VBox Networking
NIC_FLAG = "--nic1"
NIC_TYPE = "natnetwork"

NAT_NET_FLAG = "--nat-network1"
NAT_NET_NAME = ""             # Set this to the NAT network you want 

# Mounted folders:
HOST_SHARED_SCRIPTS_DIR = "" # point at shared-scripts dir
VM_SHARED_SCRIPTS_DIR = "/tmp/vagrant/shared-scripts"

HOST_SHARED_CONFIGS_DIR = "" # point at shared-configs dir
VM_SHARED_CONFIGS_DIR = "/tmp/vagrant/shared-configs"

HOST_CONFIG_DIR = "configs" # each box dir should have a subdir called "configs"
VM_CONFIG_DIR = "/tmp/vagrant/configs"

HOST_SCRIPTS_DIR = "scripts" # each box sid should have a subdir called "scripts"
VM_SCRIPTS_DIR = "/tmp/vagrant/scripts"
VM_SHELL_PATH = "/usr/bin/bash" # change if needed per distro

# -------- START THE MADNESS:
Vagrant.configure("2") do |config|
    # This is our box:
    config.vm.box = VAGRANT_BASE
    config.vm.box_check_update = VAGRANT_UPDATE

    # Networking:
    config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, NIC_FLAG, NIC_TYPE]
        vb.customize ["modifyvm", :id, NAT_NET_FLAG, NAT_NET_NAME]
    end

    # We don't want the VM to access our Vfile:
    config.vm.synced_folder ".", "/vagrant", disabled: true

    # Give our box some config files, to make these real nice and automated:
    if MOUNT_FOLDERS
        config.vm.synced_folder HOST_SHARED_SCRIPTS_DIR, VM_SHARED_SCRIPTS_DIR, SharedFoldersEnableSymlinksCreate: false 
        config.vm.synced_folder HOST_SHARED_CONFIGS_DIR, VM_SHARED_CONFIGS_DIR, SharedFoldersEnableSymlinksCreate: false 

        config.vm.synced_folder HOST_CONFIG_DIR, VM_CONFIG_DIR, SharedFoldersEnableSymlinksCreate: false
        config.vm.synced_folder HOST_SCRIPTS_DIR, VM_SCRIPTS_DIR, SharedFoldersEnableSymlinksCreate: false
    end

    #          ---- VirtualBox Config:
    config.vm.provider :virtuablbox do |vb|
        vb.name = VBOX_NAME
            
        # Display the VirtualBox GUI when booting the machine
        vb.gui = VBOX_GUI
        
        # Customize the amount of memory on the VM:
        vb.memory = VBOX_MEM
        vb.cpus = VBOX_CPUS
    end 
    #          ---- VirtualBox End:

    #          ---- Provisioning:

  # We want to add our configure files before we install tools (probably):
    if MOUNT_FOLDERS
        # Config script:
        config.vm.provision "shell",   
        inline: "#{VM_SHELL_PATH} #{VM_SHARED_SCRIPTS_DIR}/configure.sh"

        # Shared Scripts:
        config.vm.provision "shell",
        inline: "#{VM_SHELL_PATH} #{VM_SHARED_SCRIPTS_DIR}/install_shared_tools.sh"

        # CVE lab specific:
        config.vm.provision "shell",
        inline: "#{VM_SHELL_PATH} #{VM_SCRIPTS_DIR}/install_tools.sh"

        # Clean up and maintenance:
        config.vm.provision "shell",
        inline: "#{VM_SHELL_PATH} #{VM_SHARED_SCRIPTS_DIR}/maintenance.sh"
    else
        # Put custom provisioning here:
        next
    end       
    #          ---- Provisioning End:
    # -------- MADNESS FINISHED.
end
