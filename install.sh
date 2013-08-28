#!/bin/sh
chmod a+x -R ./
cp ~/.zshrc ~/.zshrc_back
cp ./.zshrc_copy_to_home_dir ~/.zshrc
chmod a+x ~/.zshrc