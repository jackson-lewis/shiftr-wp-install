# Changelog

This changelog is being recorded after this project has been widely adopted by my own projects. The prior 'version' was always v1.0.0 so for this reason this changelog will kick off from v1.0.1

## v2.1.0
**03/09/22**
Minor improvements.

* NEW! Usage of `.env` file to store credentials for the project. This replaces the `.workflow/config.conf` file.
* Updated the `fetch-env` command to set the `DB_HOST` port to `3306`
* The Flexi Block template sample file comment has been updated to reference the `$settings` variable that's passed in.
* Updated to target branch for the Deploy Staging workflow to `dev`

## v2.0.0
**25/01/22**
Well, a whooping 18 months since this project last received an update...

Many features have been developed since then, yet the core project never updated, until now.

* `.scripts` renamed to `.workflow`
* `new-block`, `new-template` and `new-part` commands provide a fast and efficient way of setting up new PHP and SCSS files.
* `.gitignore` updated to work correctly out the box and includes new ignores such as `wp-content/debug.log`
* All `rsync` exclusions updated to be up-to-date with latest Shiftr files and directories.
* `wc-template` makes for easy WooCommerce template overrides.
* `fetch-site` makes it easy to get up and running with an existing project.
* Command files updated from `.bash` to `.sh`

## v1.0.4
**07/07/20**
- Bug fix on sync-db and sync-media where a semi-colon was missing from logic
- Refreshed `package.json` with repo details

## v1.0.3
**16/06/20**
> This release has been pushed early due to the discrepancies with incorrect command names.
- **New feature:** You can now define plugins that should only be active on production, such as security and caching. Define plugins by their slug in `.scripts/production-only-plugins.json` as an array. We have chosen to include [Wordfence](https://wordpress.org/plugins/wordfence/) and [WP Fastest Cache](https://wordpress.org/plugins/wp-fastest-cache/) as examples. On running `sync-db`, if the source is `production` then there will be a check against the JSON file and deactivate each plugin.
- Updates to **README**, includes correct command names and some general text changes.
- The GitHub Actions deployment files had the previous npm command names which would have caused the build to fail.


## v1.0.2
**12/06/20**
- Updates to accommodate the update of Shiftr to v1.1, following new Gulp task names
- Sample `.gitignore` has been cleaned up using globs for excluding WP core files/directories
- The `.code-workspace` file default name has changed to `project-name` as it should be encouraged to use a unique name for these files. This is due to how VS Code displays recent projects, and me not knowing who is who!


## v1.0.1
**02/06/20**
- Added the changelog
- Project now uses MIT License