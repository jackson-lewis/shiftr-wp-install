# WordPress Enhanced Workflow
Take your WordPress workflow to the next level with a suite of commands that give you back the time to create a better future for the web!

## Prerequisites

 - Your SSH key installed on all remote environments
- The [WP CLI](https://wp-cli.org/) should also be installed on both
   your local machine, and all other environments where the site will be
   available.

## Usage

 - `ssh [staging|production]` - Quickly hop into remote servers without typing or even remembering users or IP addresses. 
 - `launch-env [staging|production]` - Initially send all files and the database up to a remote server, either for staging, test or even production.
 - `dev` - Start up a task runner of your preference.
 - `build` Used by GitHub Actions to compile assets for production environment.

### Syncing Database & Media
What used to be a clumsy and sometimes lengthy process, can now be processed in just seconds with the help of these sync commands.
|Command|Description|
|--|--|
|`sync-db <source> <target>`|Sync the database between any environment in any direction.|
|`sync-media <source> <target>`|Sync the uploads directory between any environment in any direction.|
 
 And to make life even easier, there's also some pre-configured commands ready for use, such as pulling the latest from staging `get-staging` or maybe you only need the database `get-staging-db`.
 

> It is always advised you fetch the database and media together, as media is dependant on the database. Only fetch the database if you are confident there are not recent media changes.

### Woocommerce Ready
`wc-template <file>` - Copying a Woocommerce template file to your theme is a breeze with this Woo specific command. File references should be relative to the template directory within the Woocommerce plugin. For example, to get the cart-empty template, just do `wc-template cart/cart-empty.php`.
