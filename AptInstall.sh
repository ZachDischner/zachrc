#!/bin/sh

echo ">>Now adding sublime text 3 repository"
sudo add-apt-repository ppa:webupd8team/sublime-text-3
echo ">>updating apt-get"
sudo apt-get update

### First install Sublime
echo ">>Installing Sublime"
sudo apt-get install sublime-text-installer	

### Now install all of the system thingies we need
echo ">> apt-getting things like zsh, htop, python-pip, yakuake..."	
sudo apt-get install zsh htop curl wget subversion python-pip yakuake vim

### Oh-My-Zshell
echo ">>Now oh-my-zshell, hoo rah!"
curl -L http://install.ohmyz.sh | sh

### Now all of the pip tools
echo ">>getting some pip tools, things like numpy, scipy, things I always like to have" 
sudo pip install pyodbc simplejson
pip install numpy scipy pandas



