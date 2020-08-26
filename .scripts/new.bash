#!/usr/bin/env bash

CWD=${0%/*}

. $CWD/global.bash || exit 1


if [  $# -le 0 ]
then
	echo $cyan"Create a new block or template"$white
    echo "new [block|template] <slug> <name>"
    exit 1
fi

WP_THEME="wp-content/themes/shiftr"
STYLE_HEADING="Template"

FILE_TYPE=$1
SLUG=$2
NAME=$3


cp "$WP_THEME"/"$FILE_TYPE"s/.sample.php "$WP_THEME"/"$FILE_TYPE"s/$SLUG.php
sed -i '' -e 's/__NAME__/'"$NAME"'/g' "$WP_THEME"/"$FILE_TYPE"s/$SLUG.php


cp "$WP_THEME"/build/styles/"$FILE_TYPE"s/.sample.scss "$WP_THEME"/build/styles/"$FILE_TYPE"s/_$SLUG.scss
sed -i '' -e 's/__NAME__/'"$NAME"'/g' "$WP_THEME"/build/styles/"$FILE_TYPE"s/_$SLUG.scss


if [ $FILE_TYPE == "block" ]
then
    sed -i '' -e 's/.block/.block--'"$SLUG"'/g' "$WP_THEME"/build/styles/"$FILE_TYPE"s/_$SLUG.scss

    STYLE_HEADING="Block"
fi


if [ $FILE_TYPE == "block" ]
then
    sed -i '' -e "/<?php/i\\
<?php\\
echo 'hello again';\\
?>"  "$WP_THEME"/templates/flexi.php

    STYLE_HEADING="Block"
fi


sed -i '' -e "/\/\/  "$STYLE_HEADING"/a\\
@import '"$FILE_TYPE"s/"$SLUG".scss';"  "$WP_THEME"/build/styles/style.scss
