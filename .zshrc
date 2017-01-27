# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each time that oh-my-zsh is loaded.
#
# Z's faves: jonathan, agnoster, miloshadzic (kinda wanna make my own, fix the clutteredness on left and add patched fonts...)
ZSH_THEME="zd-agnoster" # My favorite and fastest, but kinda tweaky. Small changes mean you need to readjust padding
# ZSH_THEME="powerlevel9k/powerlevel9k"    # This one is dope but kinda slow
#if [[ $1 ]] then ZSH_THEME="zd-jonathan";fi

# Declutter the command line (removes zach@zachs-macbook-pro...)
export DEFAULT_USER="zach"

# Example aliases
alias zshconfig="subl ~/.zshrc"
alias ohmyzsh="subl ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git rails ruby python github git-flow osx sublime themes debian gem brew battery rvm lol virtualenvwrapper zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# To work with brew
PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# To find cabal (Haskell) installed executables
export PATH=~/.cabal/bin:$PATH


# Customize to your needs...
source $HOME/.zachrc/.alias
source $HOME/.zachrc/.func
source $HOME/.zachrc/.greeter | lolcat --animate --duration 1 --speed 50

# To find conda
echo "Using the anaconda python environment"
export PATH="$HOME/anaconda3/bin:$PATH"

#Faster terminal writing (key repeat)
defaults write NSGlobalDomain KeyRepeat -int 0

source $HOME/.oh-my-git/prompt.sh

## ZSH syntax highlighting and autosuggestions
# https://github.com/zsh-users/zsh-autosuggestions#oh-my-zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# TO BRING BACK THE CONDA PROMPT PREPENDING THE ORIGINAL PROMPT, UNCOMMENT LINES IN ~/anaconda/bin/activate 77-96