#!/bin/sh

# Check if root of project are already set
if [ -z "$ROOT" ]; then
	ROOT=$(pwd)
fi

_help(){
	echo 'Usage: ./run.sh [OPTION]'
	echo ''
	echo 'Mandatory arguments to long options are mandatory for short options too.'
	echo ''
	echo '  -h, --help \t\t\t Print help page'
	echo ''
	echo '  -p, --package PATH\t\t Specify the path to the package'
	echo ''
	echo '  -m, --main PATH\t\t Specify the path to the main file'
	echo ''
}

_sep_echo(){
	echo '-----> '$1
}

packages_path=$ROOT/packages
main_file=error
error=0
while [ $# -ne 0 ] && [ $error -eq 0 ]
do
  key="$1"
  case $key in
    --main|-m)
      shift
      main_file=$1
      shift
    ;;
    --package|-p)
      shift
      main_file=$packages_path/$1/run.py
      shift
    ;;
    --help|-h)
      error=1
      shift
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
		_sep_echo 'ERROR '$error': Need Argument[s]'
		echo 'Need help?'
		echo 'Try using -h or --help arguments'
	else
		_sep_echo 'ERROR '$error': Uknown error'
		echo 'Need help?'
		echo 'Try using -h or --help arguments'
	fi
else
	if [ $main_file = 'error' ] ;
	then
		_sep_echo 'ERROR '$error
		echo 'Need help?'
		echo 'Try using -h or --help arguments'
	else
	  if [ $# -gt 0 ]	;
	  then
	    _sep_echo 'Run '$main_file' with args '${@:1}
	  else
	    _sep_echo 'Run '$main_file' with no args'
	  fi
		PYTHONPATH=$packages_path python $main_file ${@:1}
	fi
fi
