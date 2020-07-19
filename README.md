# Chocolatey-packages

### Automatic-Updating
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-2-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->
[![jsdelivr](https://data.jsdelivr.com/v1/package/gh/tunisiano187/Chocolatey-packages/badge?style=rounded)][![pipeline status](https://gitlab.com/chocolatey-packages/automatic-updating/badges/master/pipeline.svg)](https://gitlab.com/chocolatey-packages/automatic-updating/-/commits/master) [![CodeFactor](https://www.codefactor.io/repository/github/tunisiano187/chocolatey-packages/badge)](https://www.codefactor.io/repository/github/tunisiano187/chocolatey-packages)

### Description

This repository contains chocolatey packages created and maintained by [tunisiano](https://chocolatey.org/profiles/tunisiano) that are daily updated

## Guidelines

### Reporting broken/outdated packages

If packages from this repository fail to install or a new version has been released by the software vendor for a particular package, please report it in any or all of the following ways:

Github issue: https://github.com/tunisiano187/chocolatey-packages/automatic-update/issues/new

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

### Tags ( ideas from [teknowledgist](https://github.com/teknowledgist/Chocolatey-packages/blob/master/README.md) ) ( Needs to be implemented in the current published packages )
1. **License tags**:  At least one of these are required.  
  1. *foss*: free and open source packages
  2. *freeware*: free-to-use but not open source packages
  3. *trial*: closed-source, commercial packages that eventually require a license
  4. *licensed*: closed-source, commercial packages that are free to download, but require a license to function -- even the first time

2. **Classification tags**: At least one of these are highly recommended.
  1. productivity
  2. programming
  3. utility
  4. browser
  5. driver
  6. server
  7. client
  8. addon
  9. social
  10. game
  11. media
  12. security

3. **Qualification tags**: Individually required if a package meets the qualification:
  1. portable - software does not require admin rights to install or use.
  2. notsilent - package causes windows or splash-screens to open or close.
  3. interactive - package requires interaction by the user (this ishighly discouraged).
  4. installonly - software cannot be uninstalled through Chocolatey.
  5. embedded - package `.nupkg` is self-contained and does not require additional downloads.

4. **Synonym tags**: These are the most "personal" and wide-ranging of the choices made by the maintainer and are difficult to suggest or predefine. These are also the most likely to help someone find a specific, obscure package.  Some considerations:
  1. alternate spellings, nicknames or abbreviations.  e.g. spice, 
  2. subject matter.  e.g. chemistry, architecture, geology, LaTeX, CAD, GIS, 3d
  3. purpose.  e.g. measure, plot, draft, privacy, print
  4. specific target. e.g. pdf, png, tex, dos, java
  5. replacement for. e.g. Notepad, Explorer, Acrobat

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
