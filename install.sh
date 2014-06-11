#!/bin/sh

### Setup git  (probably need to do this first)
#git config --global user.email "zach.dischner@colorado.edu"
#git config --global user.name "ZachDischner"
#ssh-keygen

./AptInstall.sh

chmod a+x -R ./
cp ~/.zshrc ~/.zshrc_back
cp ./.zshrc_copy_to_home_dir ~/.zshrc
chmod a+x ~/.zshrc


