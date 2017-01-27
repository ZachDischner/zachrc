#!/bin/sh

###### Install dev tools
echo "Installing command line tools (should already be installedl..."
xcode-select --install

###### Change shell
chsh -s $(which zsh)

###### Install Brew
echo "Installing homebrew: #ruby -e '$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)'"
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

###### zshrc
echo "Installing oh-my-zsh, then zachrc"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"


chmod a+x -R ./
cp ~/.zshrc ~/.zshrc_back
cp ./.zshrc_copy_to_home_dir ~/.zshrc
chmod a+x ~/.zshrc
cp ./.vimrc ~
cp zd-agnoster-.zsh-theme ~/.oh-my-zsh/themes

echo "Creating VIM backup directories"
mkdir ~/.vim/backup
mkdir ~/.vim/tmp

echo "Installing asciirec, a cool terminal recording session thingy"
curl -sL https://asciinema.org/install | sh

echo "Installing lolcat. Its pretty and awesome"
sudo gem install lolcat

echo "Now running the brewInstalls script:"
brewInstalls

echo ""
echo "Running CommandLineInstalls"
CommandLineInstalls

echo "Can also extract the encrypted zip file with keychains in them and move to ~/Library/Keychains"

echo ""

echo "Go download the anaconda python distribution"

echo ""

echo "Sign into dropbox, let it sync. Then run: mackup restore, this restores ssh keys and passwords and stuff"


# Sublime settings: ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings                                                                          1 ↵ ──(Tue,Oct21)─┘
# {
#     "color_scheme": "Packages/Color Scheme - Default/Monokai.tmTheme",
#     "font_size": 11,
#     "tab_size": 4,
#     "translate_tabs_to_spaces": true,
#     "highlight_modified_tabs": true,
# }
