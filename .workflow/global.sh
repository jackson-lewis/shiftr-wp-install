#!/usr/bin/env bash

export $(grep -v '^#' .env | xargs)


red=$'\e[1;31m'
green=$'\e[1;32m'
blue=$'\e[1;34m'
magenta=$'\e[1;35m'
cyan=$'\e[1;36m'
white=$'\e[0m'


get_url() {

	env=$1

	case "$env" in 
		"dev" )
			local url="$DEV_URL"
		;;
		"staging" )
			local url="$STAGING_URL"
		;;
		"production" )
			local url="$PRODUCTION_URL"
		;;
		* )
			echo "Invalid target: $env"; exit 1
		;;
	esac

	if [[ -z $url ]]
	then
		echo "URL for $env could not be resolved..."
		exit 1
	fi

	echo "$url"
}


get_host() {

	local env=$1

	local relative_path=$2

	case "$env" in 
		"dev" )
			local user="-"
			local host="-"
			local path="-"
		;;
		"staging" )
			local user="$STAGING_USER"
			local host="$STAGING_HOST"
			local path="$STAGING_PATH"
		;;
		"production" )
			local user="$PRODUCTION_USER"
			local host="$PRODUCTION_HOST"
			local path="$PRODUCTION_PATH"
		;;
		* )
			echo "Invalid environment: $env"; exit 1
		;;
	esac

	if [[ -z $user ]]
	then
		echo "URL for $env could not be resolved..."
		exit 1
	fi

	if [[ -n $relative_path ]]
	then
		path="$path"/"$relative_path"
	fi

	ssh_host="$user"@"$host":"$path"

	if [[ "$relative_path" == "root" ]]
	then
		ssh_host="$user"@"$host"
	fi

	# Reset if on dev
	if [ "$env" == "dev" ]
	then
		ssh_host="$relative_path"
	fi

	echo "$ssh_host"
}

