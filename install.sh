#!/bin/sh
chmod a+x -R ./
cp ~/.zshrc ~/.zshrc_back
cp ./.zshrc_copy_to_home_dir ~/.zshrc
chmod a+x ~/.zshrc

echo "Trying to install htop"
curl -O http://themainframe.ca/wp-content/uploads/2011/06/htop.zip
unzip htop.zip
sudo mv htop /bin
rm htop.zip

echo "Installing asciirec, a cool terminal recording session thingy"
curl -sL https://asciinema.org/install | sh


echo "Now running the brewInstalls script:"
brewInstalls

echo "Now go import the VPN files included in .zachrc/VPN,  using the Network utility,if you're using a mac"
echo "Can also extract the encrypted zip file with keychains in them and move to ~/Library/Keychains"


# Sublime settings: ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings                                                                          1 ↵ ──(Tue,Oct21)─┘
# {
#     "color_scheme": "Packages/Color Scheme - Default/Monokai.tmTheme",
#     "font_size": 11,
#     "tab_size": 4,
#     "translate_tabs_to_spaces": true,
#     "highlight_modified_tabs": true,
# }