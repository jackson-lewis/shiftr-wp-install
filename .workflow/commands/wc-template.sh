#!/usr/bin/env bash

. .workflow/global.sh || exit 1


if [  $# -le 0 ]
then
    echo -e $red"No file supplied!"$white "Pass a Woocommerce template file to copy to your theme. You only need to include the file path relative to the template directory within Woocommerce."
    echo
    echo "Example: woo-override checkout/form-billing.php"
    exit 1
fi


# Check Woocommerce is installed
if ! $(wp plugin is-installed woocommerce); then
    echo $red"Error!"$white "Woocommerce is not installed."

    exit 1
fi

if [[ -e wp-content/themes/shiftr/woocommerce/"$1" ]]
then
    echo $red"$1 already exists in your theme."$white
    exit 1
fi

# Create Woocommerce template directory in theme
mkdir -p wp-content/themes/shiftr/woocommerce


cd wp-content/plugins/woocommerce/templates

if [[ ! -e "$1" ]]; then
    echo $red"Error!"$white "The Woocommerce template file you are referencing does not exist. Check the path and/or filename is correct."

    exit 1
fi


# Copy Woocommerce file to theme
rsync -R $1 ../../../themes/shiftr/woocommerce/
