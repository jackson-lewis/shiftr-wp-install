#!/usr/bin/env bash

. .workflow/global.sh || exit 1

echo $cyan'Preparing to fetch site...'$white

TARGET="staging"

REMOTE_LOCATION=$(get_host $TARGET)
SQL_EXPORT_FILE="fetch-env.sql"


ssh $(get_host $TARGET "root") "
    cd $( echo "$STAGING_PATH" );
    wp db export $( echo "$SQL_EXPORT_FILE" );
"

echo "Downloading all files..."
rsync -avz "$REMOTE_LOCATION"/ ./

# Setup DB credentials
echo "Setting wp-config.php constants"
wp config set DB_NAME "dev_""$BARE_DOMAIN"
wp config set DB_USER "root"
wp config set DB_PASSWORD "root"
wp config set DB_HOST "localhost"
wp config set WP_ENVIRONMENT_TYPE "development"

# Create DB and import
wp db create
wp db import $SQL_EXPORT_FILE

wp config set DB_HOST "127.0.0.1:8889"

# Clean up, remove exported SQL file.
rm $SQL_EXPORT_FILE

ssh $(get_host $TARGET "root") "
    cd $( echo "$STAGING_PATH" );
    rm $( echo "$SQL_EXPORT_FILE" );
"

# Use sync-db to get database setuo correctly.
.workflow/commands/sync-db.sh staging dev
