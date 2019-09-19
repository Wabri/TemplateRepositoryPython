#!/bin/bash

# Check if root of project are already set
if [ -z "$ROOT" ]; then
	ROOT=$(pwd)
fi

packages_path=$ROOT/packages
environment_path=$package_path/env
main_file=$packages_path/$1/run.py

if [ ! -f "$main_file" ]; then
	echo 'The '$1' package not exists'
	exit 1
fi

_sep_echo(){
	echo '---------------------------'
	echo $1
}

_sep_echo 'Run '$1
PYTHONPATH=$packages_path python $main_file ${@:2}

_sep_echo ''
