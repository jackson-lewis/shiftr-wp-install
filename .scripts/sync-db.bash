#!/usr/bin/env bash

CWD=${0%/*}

. $CWD/global.bash || exit 1


if [  $# -le 0 ]
then
    echo -e "<source> and <target> can be any of dev|staging|production"
    exit 1
fi

echo $cyan'Doing database sync...'$white
echo
echo 'Source environment is:' $1;
echo 'Target environment is:' $2;
echo

source=$1
target=$2

if [ "$source" == "$target" ]
then
	echo $red"Error!"$white "Source and target cannot be the same."
fi


if [[ $target =~ ^(staging|production)$ ]]
then
    read -p "Are you sure you want to push to $target? " -r
    echo

    if [[ ! $REPLY =~ ^(y|Y|yes|YES|Yes|yea|yeah)$ ]]
    then
        echo $cyan"Cancelling database sync"$white
        exit 1
    fi
fi


SOURCE_URL=$( get_url $source )
TARGET_URL=$( get_url $target )

echo "Source URL is: $SOURCE_URL"
echo "Target URL is: $TARGET_URL"
echo

sync_db() {

	wp_cli_source="@$source"
	wp_cli_target="@$target"

	# Check for endpoints
	if [ "$source" == "dev" ]
	then
		wp_cli_source=""

	elif [ "$target" == "dev" ]
	then
		wp_cli_target=""
	fi

	# Backup the target database
	echo "Backing up the $target database..."
	wp $wp_cli_target db export || exit 1

	echo "Resetting the $target database..."
	wp $wp_cli_target db reset --yes || exit 1

	# Do the import into the target db
	echo "Importing $source database into $target..."
	wp $wp_cli_source db export - | wp $wp_cli_target db import - || exit 1

	# Change URLs
	echo "Updating URLs in $target database..."
	wp $wp_cli_target search-replace "$SOURCE_URL" "$TARGET_URL" --skip-columns=guid --report=0 || exit 1

	# Flush the cache
	wp $wp_cli_target cache flush

	# Move backup sql files
	if [ -f *.sql ]; then
		echo "Moving database backups..."
		mkdir -p .backups

		for pathname in *.sql; do
			gzip -c "$pathname" > ".backups/$( basename "$pathname" ).gz" && rm $pathname
		done
	fi

	echo $green"Database sync complete!"$white
}

sync_db

