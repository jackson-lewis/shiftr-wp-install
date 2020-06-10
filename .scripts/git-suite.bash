#!/usr/bin/env bash

CWD=${0%/*}

. $CWD/global.bash || exit 1


if [  $# -le 0 ]
then
	echo $cyan"Do sweet git stuff"$white
    exit 1
fi


SUBCOMMAND=$1

# Get the latest changes from current branch
if [[ "update-branch" == $SUBCOMMAND ]]; then

    git pull origin HEAD
fi

# Update current branch with changes from default branch
if [[ "update-branch" == $SUBCOMMAND ]]; then

    git pull origin/HEAD
fi
