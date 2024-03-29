#!/bin/sh

ROOT=$(pwd)

_sep_echo(){
	echo '-----> '$1
}

_help(){
	echo 'Usage: ./source.sh [OPTION]'
	echo ''
	echo 'Mandatory arguments to long options are mandatory for short options too.'
	echo ''
	echo '  -h, --help \t\t\t Print help page'
	echo ''
	echo '  -q, --quiet \t\t\t Quiet mode with no output'
	echo ''
	echo '  -n, --name NAME\t\t Specify the name of virtual environment'
	echo ''
	echo '  -p, --package NAME\t\t Specify the name of the package'
	echo ''
	echo '  -c, --cache \t\t\t Use environment if already exists'
	echo ''
}

_venv_create() {
	  rm -rf $1 &>/dev/null
	  python3 -m venv $1
}

_source() {
  cache=$3
	package_path=$2
	environment_name=$package_path/$1
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

  if [ $cache -eq 0 ] ;
  then
	  _sep_echo 'Setting up virtual environment'
	  echo 'Create environment with name '$environment_name
    _venv_create $environment_name
	elif [ $cache -eq 1 ]
	then
	  if [ ! -f $environment_name/bin/activate ] ;
	  then
	    _sep_echo 'Environment not exists, create new one'
	    echo 'Create environment with name '$environment_name
      _venv_create $environment_name
    else
	    _sep_echo 'Cashing environment'
	    echo 'Using environment with path: '$environment_name
      _venv_create $environment_name
    fi
	fi

	# Activate up Environment
	_sep_echo 'Activate Environment'
	. $environment_name/bin/activate
	echo 'The python environment is in path '$(which python)
	echo 'The pip environment is in path '$(which pip)

	# Upgrade pip and install requirements
	_sep_echo 'Upgrade pip'
	pip install --upgrade pip
	_sep_echo 'Install requirements of project'
	pip install -r $package_path/requirements.txt

	# Create aliases
	_sep_echo 'Create aliases'
	if [ "$package_path" = "$ROOT" ] ; then
		alias run='$tools/run.sh --package '
	else
		run_file_package=$package_path/run.py
		alias run='$tools/run.sh --main $run_file_package'
	fi
	if [ "$package_path" = "$ROOT" ] ; then
		alias requirement='$tools/pip-update-requirements.sh --requirements $ROOT/requirements.txt'
	else
		alias requirement='$tools/pip-update-requirements.sh --requirements $package_path/requirements.txt'
	fi
}

environment_name=venv
package_path=$ROOT
quiet=0
cache=0
error=0
while [ $# -ne 0 ] && [ $error -eq 0 ]
do
  key="$1"
  case $key in
    --help|-h)
      error=-1
    ;;
    --quiet|-q)
      quiet=1
      shift
    ;;
    --cache|-c)
      cache=1
      shift
    ;;
    --name|-n)
      environment_name=$2
      shift
      shift
    ;;
    --package|-p)
      package_path=$ROOT'/packages/'$2
      if [ ! -d $package_path ]; then
        echo 'The '$2' package not exists'
        error=2
      fi
      shift
      shift
    ;;
    *)
      echo 'Argument '$key' not valid'
      error=1
  esac
done

if [[ $error -eq -1 ]] ;
then
	_help
elif [[ $error -eq 0 ]]
then
	if [[ $quiet -eq 0 ]] ; then
		_source $environment_name $package_path $cache
	else
		_source $environment_name $package_path $cache &>/dev/null
	fi
else
	echo 'ERROR '$error
	echo 'Need help?'
	echo 'Try using -h or --help arguments'
fi
