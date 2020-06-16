# Changelog

This changelog is being recorded after this project has been widely adopted by my own projects. The prior 'version' was always v1.0.0 so for this reason this changelog will kick off from v1.0.1

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