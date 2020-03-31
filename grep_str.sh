#!/bin/bash

USAGE="Usage: ./grep_str.sh [directory_path] [string]\n"

if [ $# -le 1 ]; then
	printf "$USAGE"
	exit 1
fi

if [[ ( $# == "--help" ) || ( $# == "-h" ) ]]; then
	printf "$USAGE"
	exit 0
fi

if [ ! -d $1 ]; then
	printf "'$1': Directory \'$1\' \x1b[31mDOES NOT \x1b[0mexists\n"
	exit 1
fi

DIRECTORY="$( cd "$( dirname "$1" )" && pwd -P )"
STRING=$2

for File in `ls $DIRECTORY`
do
	if [ ! -d "${File}" ]; then
		temp=$(cat ${File} | grep -n ${STRING})
		if [ ${#temp} -ne 0 ]; then
			printf "\x1b[31mIn ${DIRECTORY}/${File}:\n"
			printf "\x1b[0m${temp}\n\n"
		fi
	fi
done
