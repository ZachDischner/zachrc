#!/bin/sh

sudo add-apt-repository ppa:webupd8team/sublime-text-3
sudo apt-get update

### First install Sublime
sudo apt-get install sublime-text-installer	

### Now install all of the system thingies we need	
sudo apt-get install zsh htop curl wget subversion python-pip

### Oh-My-Zshell
curl -L http://install.ohmyz.sh | sh

### Now all of the pip tools
sudo pip install pyodbc simplejson
pip install numpy scipy pandas

