#!/usr/bin/env bash

. .workflow/global.sh || exit 1


if [  $# -le 0 ]
then
	echo $cyan"SSH into a remote project environment via the credentials in config.conf"$white
    exit 1
fi


# Check destination is allowed
if [ "$TARGET" == "dev" ]
then
	echo $red"Error!"$white "Launch target can only be either staging|production"

	exit 1
fi


echo $cyan'Diving into '"$1"' SSH...'$white
echo

TARGET=$1

case "$TARGET" in
	"staging" )
		remote_path="$STAGING_PATH"
	;;
	"production" )
		remote_path="$PRODUCTION_PATH"
	;;
	* )
		echo "Invalid target: $env"; exit 1
	;;
esac

if [[ -z $remote_path ]]
then
	echo "Remote path for $env could not be resolved..."
	exit 1
fi


# Go in...
ssh $(get_host $TARGET "root")

