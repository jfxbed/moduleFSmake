#! /bin/bash
WEEKS=10
SEMESTER=""
FPATH=""
REVISION=0
echo "  __  __           _       _        _____ ____    __  __       _        "
echo " |  \/  | ___   __| |_   _| | ___  |  ___/ ___|  |  \/  | __ _| | _____ "
echo " | |\/| |/ _ \ / _\` | | | | |/ _ \ | |_  \___ \  | |\/| |/ _\` | |/ / _ \ "
echo " | |  | | (_) | (_| | |_| | |  __/ |  _|  ___) | | |  | | (_| |   <  __/ "
echo " |_|  |_|\___/ \__,_|\__,_|_|\___| |_|   |____/  |_|  |_|\__,_|_|\_\___| "
echo ""


while getopts "rhs:w:" opt; do
  case $opt in
    r)
    REVISION=1
    echo "Revision Folder Added"
    ;;
    s)
    SEMESTER="S${OPTARG}_"
    echo "Semester prefix set as: $SEMESTER"
    ;;
    w)
    WEEKS=$OPTARG
    echo "Number of weeks in semester set as: $WEEKS"
    ;;
	h)
  	printf "Usage: [OPTION] [MODULE NAME]\nCreates a filesystem for a Module.\n-s\tAdds a semester prefix to the directory name\n-w\tSets the number of weeks in the Module\n-r\tAdds A Revision Folder to the Directory Structure\n\n"
	exit 1
  	;;
	\?)
  	echo "Invalid option: -$OPTARG"
  	;;
	:)
  	echo "Option -$OPTARG requires an argument."
  	;;
  esac
done

shift $((OPTIND - 1))

if [[ $1 == "" ]]; then
    printf "FATAL ERROR: No Module Name Supplied\n"
    exit 1
fi

echo "Creating Module Filesystem"

FPATH="$SEMESTER$1"
mkdir "$FPATH"
mkdir "./$FPATH/Readings"
mkdir "./$FPATH/Assignments"
mkdir "./$FPATH/Past-Papers"

echo "Creating Week Sub-Filesystem"

if [ $REVISION -eq 1 ]; then
  mkdir "./$FPATH/Revision"
fi

mkdir "./$FPATH/Weeks"
for i in $(seq 1 $WEEKS) 
do
    mkdir "./$FPATH/Weeks/Week_$i"
done

echo "Operations Completed"
