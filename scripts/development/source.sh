#!/bin/sh

ROOT=$(pwd)

_sep_echo(){
	echo '---------------------------'
	echo $1
}

if [[ $# -eq 0 ]] ; then
	environment_name=venv
    _sep_echo 'No arguments passed'
else
	environment_name=$1
fi
tools=$ROOT/scripts/development/tools

# Install python3 dependencies
_sep_echo 'Install python3 venv and pip dependencies'
sudo apt install python3-venv
sudo apt install python3-pip

# Create  Environment
_sep_echo 'Deactivate precedent environment'
if type deactivate &>/dev/null; then
    deactivate
else
	echo 'There are not any environment activated'
fi

_sep_echo 'Setting up virtual environment'
echo 'Create environment with name '$environment_name
rm -rf $environment_name &>/dev/null
python3 -m venv $environment_name

# Activate up Environment
_sep_echo 'Activate Environment'
. $environment_name/bin/activate
echo 'The python environment is in path '$(which python)
echo 'The pip environment is in path '$(which pip)

_sep_echo 'Upgrade pip'
pip install --upgrade pip

_sep_echo 'Install requirements of project'
pip install -r ./requirements.txt

_sep_echo 'Create aliases'
alias run='$tools/run.sh'

_sep_echo ''
