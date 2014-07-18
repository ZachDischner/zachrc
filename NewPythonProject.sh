#/bin/bash
echo "Creating new python project structure in " $1
source $HOME/.zachrc/.alias > /dev/null

echo "Initializing empty git repository"
git init $1  > /dev/null
cd $1 

echo "Creating input and output directories"
mkdir Output
mkdir Input

echo "Adding .gitignore and readme files"
touch .gitignore
touch README.md

echo "Cloning doxygen and ZDUtil submodules with: "
alias setuppythondoxygen
alias setuppythonzdutil
setuppythondoxygen
setuppythonzdutil
cp $HOME/.zachrc/Files/Template.py $1