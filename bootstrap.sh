#!/bin/bash
sudo yum install -y epel-release
sudo yum install -y sshpass net-tools psmisc htop tmux git
git clone https://github.com/aksaramaya/kubernetes-setup.git /tmp/kube
cd /tmp/kube
sudo make
