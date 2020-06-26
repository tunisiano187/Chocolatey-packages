## Automatic Folder
[![Chocolatey Version](https://img.shields.io/chocolatey/v/chocolatey)](www.chocolatey.org)

This is where you put your Chocolatey packages that are automatically packaged up by [AU](https://chocolatey.org/packages/au)

### Automatic Updater (AU)

AU works with packages without automatic package tokens necessary. So you can treat the packages as normal.

**NOTE:** Ensure when you are creating packages for AU, you don't use `--auto` as the packaging files should be normal packages. AU doesn't need the tokens to do replacement.

The following packages implement this strategy of auto updates:

* html-tidy
* nexus-oss
