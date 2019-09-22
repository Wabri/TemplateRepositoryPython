#/bin/sh
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

if [ $(($# % 2)) -eq 1 ]; then
	echo 'Arguments must be full'
	_help
	exit 2
fi

while [ $# -gt 0 ]
do
	key="$1"

	case $key in
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
			_help
			exit 0
		;;
		*)
			echo 'Argument '$key' not valid'
			echo 'Need help?'
			echo 'Try using -h or --help argument'
			exit 2
		;;
	esac
done

TEMPLATEDIR=$(pwd)

if [ -z "$DIRECTORY" ]; then
	DIRECTORY=$HOME
fi
echo 'The directory of the project is: '$DIRECTORY
if [ -z "$NAME" ]; then
	NAME='new_python_project'
fi
echo 'The name of the project is: '$NAME

# Define the real path of the project
PROJECTPATH=$DIRECTORY/$NAME
# Copy the template directory and create the new project
mkdir -p $PROJECTPATH
cp -R $TEMPLATEDIR/. $PROJECTPATH
cd $PROJECTPATH
rm -rf .git/

if [ -z "$REPOSITORY" ]; then
	exit 0
else
	echo 'The remote git repository is: '$REPOSITORY
	git init
	git remote add origin $REPOSITORY
fi
