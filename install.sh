#!/bin/bash
_help(){
	echo 'Usage: ./install.sh [OPTION]'
	echo ''
	echo 'Mandatory arguments to long options are mandatory for short options too.'
	echo ''
	echo '  -d, --directory DIRECTORY\t\t Specify the destination path of the project'
	echo ''
	echo '  -n, --name NAME\t\t\t Specify the name of the project'
	echo ''
	echo '  -r, --repository REPOSITORY\t\t Specify the remote repository of the project'
	echo ''
}

_sep_echo(){
	echo '-----> '$1
}

DIRECTORY=error
REPOSITORY=error
NAME=error
upgrade=0
error=0

while [ $# -gt 0 ] && [ $error -eq 0 ]
do
	key="$1"

	case $key in
		-u|--upgrade)
			upgrade=1
			shift
		;;
		-d|--directory)
			DIRECTORY="$2"
			shift
			shift
		;;
		-n|--name)
			NAME="$2"
			shift
			shift
		;;
		-r|--repository)
			REPOSITORY="$2"
			shift
			shift
		;;
		-h|--help)
      error=1
		;;
		*)
      error=2
		;;
	esac
done

if [ $error -gt 0 ] ;
then
  if [ $error -eq 1 ] ;
  then
    _help
  elif [ $error -eq 2 ] ;
  then
		echo 'Arguments not valid'
		echo 'Need help?'
		echo 'Try using -h or --help argument'
	fi
	else
    echo ''
    _sep_echo './install.sh script start'
    TEMPLATEDIR=$(pwd)

    if [ -z "$DIRECTORY" ] ;
    then
    	DIRECTORY=$HOME
    fi
    if [ -z "$NAME" ] ;
    then
    	NAME='New_Python_Project'
    fi

    # Define the real path of the project
    PROJECTPATH=$DIRECTORY/$NAME
    # Copy the template directory and create the new project
    if [ -d $PROJECTPATH ] ;
    then
      if [ $upgrade -eq 1 ] ;
      then
        _sep_echo 'Upgrade project'
        cp -R $TEMPLATEDIR/scripts $PROJECTPATH
        echo 'Done'
      else
        _sep_echo 'Project already exists'
        echo 'If need an upgrade use the upgrade argument'
		    echo 'Need help?'
		    echo 'Try using -h or --help argument'
      fi
    else
      _sep_echo 'Creation of the project directory'
      mkdir -p $PROJECTPATH
      echo 'The directory of the project is: '$DIRECTORY
      _sep_echo 'Coping files and directories'
      cp -R $TEMPLATEDIR/. $PROJECTPATH
      echo 'The name of the project is: '$NAME
      cd $PROJECTPATH
      _sep_echo 'Removing useless files and directories'
      rm -rf .git/ venv/ install.sh resources/*

      if [ ! -d $REPOSITORY ] &&  [ ! $REPOSITORY = "error" ] ;
      then
      	_sep_echo 'Setting up the git repository'
      	echo 'The remote git repository is: '$REPOSITORY
      	git init --quiet
      	git remote add origin $REPOSITORY
      fi
    fi
fi

