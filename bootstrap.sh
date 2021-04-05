#!/bin/bash

#Author: Alhamdu U Bello
#Date: 6th Feb 2021
#Description: Bootstrap master
#VARS
export SSHPUBKEY="/home/vagrant/.ssh/id_rsa"
#
export ROOTSSHDIR="/root/.ssh"
export ROOTAUTKEYS="/root/.ssh/authorized_keys"
#
export MACHINEIP=`ip address show | grep eth1 | tail -n 1 | awk '{print $2}' | sed 's/\/24//g'`
export MACHINENAME1=`hostnamectl | grep Static | awk '{print $3}' | cut -d '.' -f1`
export MACHINENAME2=`hostnamectl | grep Static | awk '{print $3}'`
#
#
export PROJECT="/home/vagrant/autompls"
#
export USER="vagrant"
export GRP="vagrant"
#
export UNAME="Alhamdu U Bello"
export EMAIL="alhamdubello@gmail.com"
#
#START OF SCRIPT
#
#1. Update master from default repo
sudo dnf update -y

#2. Install epel-release.noarch
sudo dnf install epel-release.noarch -y

#3. Install my dev tools like vim, bash-completion, git
sudo dnf install vim nano bash-completion git tree -y

#4. Install ansible
sudo dnf install ansible -y

#5. Configure /etc/hosts
sudo chmod 766 /etc/hosts
sudo echo "$MACHINEIP $MACHINENAME1 $MACHINENAME2" >> /etc/hosts
sudo chmod 744 /etc/hosts

#6 Setup Ansible Project folders
mkdir -p $PROJECT/{roles,templates,host_vars,group_vars,includes}

#7 Setup Ansible config files
touch $PROJECT/{ansible.cfg,hosts,site.yml}
chown -R $USER:$GRP $PROJECT

#7.1 Adding my git config
cp -R /vagrant/config/.gitconfig /home/vagrant
chown -R $USER:$GRP /home/vagrant
cd $PROJECT
git init .
git add .
git commit -m'First Commit'

#8. Also generate ssh keys for user vagrant
if sudo test ! -f "$SSHPUBKEY"; then
        echo "Generating ssh keys now..."
        sleep 5
        cat /dev/zero | ssh-keygen -q -N "" > /dev/null
        echo " "
        echo "Your public ssh-key is shown below: "
        echo " "
        sleep 5
        cat "$SSHPUBKEY"
else
	echo "Skipping vagrant key creation..."
fi

#9. Create root .ssh/authorized_keys
if sudo test ! -d "$ROOTSSHDIR"; then
	sudo mkdir -p "$ROOTSSHDIR"
	echo "$ROOTSSHDIR has now been created."
else
	echo "Skipping root .ssh dir creation..."
fi

#10. Test for Authorized_keys file in /root/.ssh/
if sudo test ! -f "$ROOTAUTKEYS"; then
	sudo chmod 766 "$ROOTSSHDIR"
	sudo touch "$ROOTAUTKEYS"
	sudo chmod 766 "$ROOTAUTKEYS"
	sudo cat "$SSHPUBKEY" >>  /tmp/authorized_keys
	sudo mv /tmp/authorized_keys "$ROOTAUTKEYS"
	sudo chown root:root "$ROOTAUTKEYS"
	sudo chmod 600 "$ROOTAUTKEYS"
	sudo chmod 600 "$ROOTSSHDIR"
	echo "vagrant ssh-keys have now been added to /root/.ssh/authorized_keys..."
else
	echo "Skipping adding vagrant keys to /root/.ssh/authorized_keys..."
fi
#
#
#END OF SCRIPT
