#!/bin/sh
chmod a+x -R ./
cp ~/.zshrc ~/.zshrc_back
cp ./.zshrc_copy_to_home_dir ~/.zshrc
chmod a+x ~/.zshrc

echo "Now go import the VPN files included in .zachrc/VPN,  using the Network utility,if you're using a mac"
echo "Can also extract the encrypted zip file with keychains in them and move to ~/Library/Keychains"