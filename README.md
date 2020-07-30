# Chocolatey-packages

### Automatic-Updating
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-2-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->
[![jsdelivr](https://data.jsdelivr.com/v1/package/gh/tunisiano187/Chocolatey-packages/badge?style=rounded)](https://gitlab.com/chocolatey-packages/automatic-updating)[![pipeline status](https://gitlab.com/chocolatey-packages/automatic-updating/badges/master/pipeline.svg)](https://gitlab.com/chocolatey-packages/automatic-updating/-/commits/master) [![CodeFactor](https://www.codefactor.io/repository/github/tunisiano187/chocolatey-packages/badge)](https://www.codefactor.io/repository/github/tunisiano187/chocolatey-packages)

### Description

This repository contains chocolatey packages created and maintained by [tunisiano](https://chocolatey.org/profiles/tunisiano) that are daily updated

### Patreon
<a href="https://www.patreon.com/bePatron?u=39585820" data-patreon-widget-type="become-patron-button">Become a Patron!</a>

## Guidelines

### Reporting broken/outdated packages

If packages from this repository fail to install or a new version has been released by the software vendor for a particular package, please report it in any or all of the following ways:

Github issue: https://github.com/tunisiano187/chocolatey-packages/issues/new

### Broken packages

If the package fails to install or uninstall via choco, please include debug information from the console:
choco install PKGID --yes --verbose --debug

### Outdated packages

If the package is not up to date, please include the following if possible:

latest version number
release date
URL to the install binary

### Contributing
1. As much as possible, these packages are [automatic](https://chocolatey.org/docs/automatic-packages) and all automatic packages will use the [AU module](https://github.com/majkinetor/au).
2. If allowed, packages will include the packaged software directly in the `.nupkg` archive instead of downloading it from another site at the time of install.  Only tools that allow redistribution in their license can be embedded and such packages must include two additional files in the `tools` directory - `VERIFICATION.txt` and `License.txt`.
3. Code is written for humans, not for computers (i.e. assembly). Make the code readable and commented, but also efficient. The goal is not to obfuscate. If another one wants to help, he needs to understand it too!
4. All the metadata attributes in the package needs to be filled up as much as possible. If a metadata tag is empty, it is because the information is not available. In case of the metadata should be publicly presented as it is important, but still not available on the net, you could need to contact the publisher of the software.

### Tags
Read this [Page](https://github.com/tunisiano187/Chocolatey-packages/wiki/Tags.md)

## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://github.com/RedBaron2"><img src="https://avatars1.githubusercontent.com/u/1191271?v=4" width="100px;" alt=""/><br /><sub><b>RB</b></sub></a><br /><a href="https://github.com/tunisiano187/Chocolatey-packages/issues?q=author%3ARedBaron2" title="Bug reports">🐛</a></td>
    <td align="center"><a href="https://www.bowlman.org"><img src="https://avatars2.githubusercontent.com/u/6095739?v=4" width="100px;" alt=""/><br /><sub><b>Tunisiano18</b></sub></a><br /><a href="https://github.com/tunisiano187/Chocolatey-packages/commits?author=tunisiano187" title="Code">💻</a></td>
  </tr>
</table>

<!-- markdownlint-enable -->
<!-- prettier-ignore-end -->
<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
