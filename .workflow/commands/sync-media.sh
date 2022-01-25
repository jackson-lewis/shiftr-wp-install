#!/usr/bin/env bash

. .workflow/global.sh || exit 1


if [  $# -le 0 ]
then
    echo -e "<source> and <target> can be any of dev|staging|production"
    exit 1
fi

echo $cyan'Doing media sync...'$white
echo
echo 'Source environment is:' $1 $(get_url $1)
echo 'Target environment is:' $2 $(get_url $2)
echo

source=$1
target=$2

if [ "$source" == "$target" ]
then
	echo $red"Error!"$white "Source and target cannot be the same."

	exit 1
fi


if [[ $target =~ ^(staging|production)$ ]]; then
    read -p "Are you sure you want to push to $target? " -r
    echo

    if [[ ! $REPLY =~ ^(y|Y|yes|YES|Yes|yea|yeah)$ ]]; then
        echo $cyan"Cancelling media sync"$white
        exit 1
    fi
fi


# Assign target variables
SOURCE_LOCATION=$(get_host $source "$WP_UPLOADS_DIR")
TARGET_LOCATION=$(get_host $target "$WP_UPLOADS_DIR")


# Sync all files to the target environment
rsync -avzh "$SOURCE_LOCATION" "$TARGET_LOCATION" --delete

echo $green"Media sync complete!"$white

