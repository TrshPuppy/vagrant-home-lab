# Vagrant VM Environment
This repo is dedicated to Hashimoto and the spirit of automation! The point is to have ready go scripts and Vagrantfiles to build VMs of various use-cases. 

## The Problem(s):
I suddenly needed so many VMs!
- WSL is toxic for coding and building cross-platform Electron apps
- [PNPT](https://github.com/TrshPuppy/PNPT-study-guide) requires a kali VM for ethical hacking
- I'd like to start dabbling in [malware reverse engineering](https://github.com/TrshPuppy/PMAT-study-guide/tree/1fee3f22a5b61bb473f0eefe0b7191fcdbe3a738)
- & I'm tired of [Hack the Box's](https://app.hackthebox.com/profile/1343592) Pwn Box

## The Solution:
I decided to learn [Vagrant](https://developer.hashicorp.com/vagrant/docs)
> *"Virtual machines shall spring forth from thy computer and populate the cloud" 1SRE 1:1"*

## The Dream:
Eventually I want this repo to support easy creation and deployment of VMs for software development, pentesting (attack VMs as well as target VMs) and malware analysis!

## Updates & Use:
The [ubuntu-dev](/ubuntu-dev/Vagrantfile) VM is a good example of how VMs in this environment carryout automated provisioning and configuration. In each VM's Vagrantfile, shared bash scripts and config files in the `shared-scripts` and `shared-configs` directories can be used to automate provisioning. For example, my [`.vimrc`](/shared-configs/.vimrc) in `shared-configs` can be automatically copied over to the home directory of the VM via provisioning in the Vagrantfile.

Additionally, each VM has local directories for holding scripts and configurations unique to the VM and its needs. This structure is meant to make deploying **provisioned** VMs as quick and painless as possible.
