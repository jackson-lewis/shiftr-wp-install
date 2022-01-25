#!/usr/bin/env bash

. .workflow/global.sh || exit 1


if [  $# -le 0 ]
then
	echo $cyan"Create a new block or template"$white
    echo "new [block|template|part] <slug> <name>"
    exit 1
fi

WP_THEME="wp-content/themes/shiftr"
STYLE_HEADING="Template"

FILE_TYPE=$1
SLUG=$2
NAME=$3

if [[ -e "$WP_THEME"/"$FILE_TYPE"s/$SLUG.php ]]
then
    echo $red"This $FILE_TYPE already exists."$white
    exit 1
fi

if [ $FILE_TYPE == "part" ]
then
    mkdir -p "$WP_THEME"/src/styles/parts
fi


cp .workflow/sample-files/"$FILE_TYPE".php "$WP_THEME"/"$FILE_TYPE"s/$SLUG.php
sed -i '' -e 's/__NAME__/'"$NAME"'/g' "$WP_THEME"/"$FILE_TYPE"s/$SLUG.php


cp .workflow/sample-files/"$FILE_TYPE".scss "$WP_THEME"/src/styles/"$FILE_TYPE"s/_$SLUG.scss
sed -i '' -e 's/__NAME__/'"$NAME"'/g' "$WP_THEME"/src/styles/"$FILE_TYPE"s/_$SLUG.scss
sed -i '' -e 's/__SLUG__/'"$SLUG"'/g' "$WP_THEME"/src/styles/"$FILE_TYPE"s/_$SLUG.scss


if [ $FILE_TYPE == "block" ]
then
    STYLE_HEADING="Block"
fi

if [ $FILE_TYPE == "part" ]
then
    STYLE_HEADING="Part"
fi


sed -i '' -e "/\/\/  "$STYLE_HEADING"/a\\
@import '"$FILE_TYPE"s/"$SLUG"';"  "$WP_THEME"/src/styles/main.scss