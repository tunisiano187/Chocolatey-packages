# Chocolatey Packages

<!--
  SPDX-FileCopyrightText: © 2020–2022, Fabian Clerbois <fabian@bowlman.org>
  SPDX-FileCopyrightText: 🄯 2025, Peter J. Mello <admin@petermello.net>

  SPDX-License-Identifier: AGPL-3.0-or-later
-->
[![All Contributors][all-contributors-badge]][contributors-table]
[![jsDelivr][jsdelivr-badge]][jsdelivr-stats]
[![Update Pipeline][pipeline-badge]][pipeline-gist]
[![CodeFactor][codefactor-badge]][codefactor-dashboard]
[![GitHub Activity][activity-badge]][commit-log]

[![Patreon][patreon-button]][patreon-page]

This repository contains Chocolatey packages ([list][package-list]) created and
maintained by [tunisiano][tunisiano-profile] that are updated daily.

## Guidelines

### Reporting broken/outdated packages

If packages from this repository fail to install, or a new version has been
released by the publisher for a particular package, please report it in any of
the following ways:

- [GitHub issue][new-ghissue]

#### Broken packages

If the package fails to install or uninstall successfully using Chocolatey
(`choco`), please include a log of the debug output from the terminal for the
exact command used:

```shell
choco install <package_name> --yes --verbose --debug
```

#### Outdated packages

If the package has fallen out-of-date, please include the following information
when opening an issue here about if, if possible:

- The most recent release's:
  - Date
  - Version number/name
  - Known good URL to the installation package

## Tags

Learn more about [package tags][tags].

## Contributing

1. As much as possible, these packages are maintained
   [automatically][automatic-packages] by the
   [AU PowerShell module][chocolatey-au].
1. If allowed, packages will include the packaged software directly in the
   `.nupkg` archive instead of downloading it from the remote source during
   installation. Only tools that allow redistribution in their license may be
   embedded this way and such packages must include two additional files in the
   `tools` directory:
   - `License.txt`
   - `VERIFICATION.txt`
1. Code is written for humans, not for computers (i.e. Assembly). Make your code
   submissions readable and adequately commented, but also efficient; the goal
   is not to obfuscate. If someone else wants to make changes to those files
   later on, they need to be able to understand what's happening and why, too!
1. All the metadata attributes in the package needs to be as complete and
   accurate as possible. If a metadata tag is empty, it is because the
   information was not available when the package was last reviewed. In
   instances where important metadata that is not available online should be
   added to the package, the publisher of the software must first be contacted
   and give permission to do so in writing.

### Contributors ✨

This project follows the [All Contributors][all-contributors] specification.
Contributions of any kind are always welcome!

Thanks go out to these wonderful people ([emoji key][emoji-key]):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table align="left" cellpadding="8" cellspacing="0" width="95%">
  <tbody>
    <tr>
      <td align="center" valign="top" width="20%"><a href="https://www.bowlman.org/"><img alt="tunisiano187's avatar" crossorigin="anonymous" decoding="sync" height="80" referrerpolicy="strict-origin" src="https://secure.gravatar.com/avatar/9c654799ceb39ed56986bb178a5e2fe6?r=g&d=retro&s=80" width="80" /><br /><span style="font-weight: 700;">Fabian Clerbois</span></a><br /><a href="https://github.com/tunisiano187/Chocolatey-packages/issues?q=author%3Atunisiano187" title="Bug reports">🐛</a> <a href="https://github.com/tunisiano187/Chocolatey-packages/commits?author=tunisiano187" title="Code">💻</a> <a href="https://github.com/tunisiano187/Chocolatey-packages/commits?author=tunisiano187" title="Documentation">📖</a> <a href="#maintenance-tunisiano187" title="Maintenance">🚧</a> <a href="#projectManagement-tunisiano187" title="Project Management">📆</a></td>
      <td align="center" valign="top" width="20%"><a href="https://www.instructables.com/member/RudyD1/instructables/"><img alt="amayii0's avatar" crossorigin="anonymous" decoding="sync" height="80" referrerpolicy="strict-origin" src="https://avatars.githubusercontent.com/u/9150547?v=4&s=80" width="80" /><br /><span style="font-weight: 700;">Rudy Dullier</span></a><br /><a href="https://github.com/tunisiano187/Chocolatey-packages/commits?author=amayii0" title="Code">💻</a></td>
      <td align="center" valign="top" width="20%"><a href="https://github.com/ordonezgs"><img alt="ordonezgs's avatar" crossorigin="anonymous" decoding="sync" height="80" referrerpolicy="strict-origin" src="https://avatars.githubusercontent.com/u/17103864?v=4&s=80" width="80" /><br /><span style="font-weight: 700;">Santiago G. Ordoñez</span></a><br /><a href="https://github.com/tunisiano187/Chocolatey-packages/commits?author=ordonezgs" title="Code">💻</a> <a href="#translation-ordonezgs" title="Translation">🌍</a></td>
      <td align="center" valign="top" width="20%"><a href="https://github.com/dgalbraith"><img alt="dgalbraith's avatar" crossorigin="anonymous" decoding="sync" height="80" referrerpolicy="strict-origin" src="https://avatars.githubusercontent.com/u/1270002?v=4&s=80" width="80" /><br /><span style="font-weight: 700;">D. Galbraith</span></a><br /><a href="https://github.com/tunisiano187/Chocolatey-packages/commits?author=dgalbraith" title="Code">💻</a></td>
      <td align="center" valign="top" width="20%"><a href="https://www.gep13.co.uk/blog"><img alt="gep13's avatar" crossorigin="anonymous" decoding="sync" height="80" referrerpolicy="strict-origin" src="https://avatars.githubusercontent.com/u/1271146?v=4&s=80" width="80" /><br /><span style="font-weight: 700;">Gary Ewan Park</span></a><br /><a href="https://github.com/tunisiano187/Chocolatey-packages/commits?author=gep13" title="Code">💻</a></td>
    </tr>
    <tr>
      <td align="center" valign="top" width="20%"><a href="https://github.com/jbarthelmes"><img alt="jbarthelmes's avatar" crossorigin="anonymous" decoding="sync" height="80" referrerpolicy="strict-origin" src="https://avatars.githubusercontent.com/u/615914?v=4&s=80" width="80" /><br /><span style="font-weight: 700;">Johannes Barthelmes</span></a><br /><a href="https://github.com/tunisiano187/Chocolatey-packages/commits?author=jbarthelmes" title="Code">💻</a></td>
      <td align="center" valign="top" width="20%"><a href="https://github.com/xmha97"><img alt="xmha97's avatar" crossorigin="anonymous" decoding="sync" height="80" referrerpolicy="strict-origin" src="https://avatars.githubusercontent.com/u/23485114?v=4&s=80" width="80" /><br /><span style="font-weight: 700;">Muhammadhussein Ammari</span></a><br /><a href="https://github.com/tunisiano187/Chocolatey-packages/commits?author=xmha97" title="Code">💻</a></td>
      <td align="center" valign="top" width="20%"><a href="https://github.com/RedBaron2"><img alt="RedBaron2's avatar" crossorigin="anonymous" decoding="sync" height="80" referrerpolicy="strict-origin" src="https://avatars.githubusercontent.com/u/1191271?v=4&s=80" width="80" /><br /><span style="font-weight: 700;">RB</span></a><br /><a href="https://github.com/tunisiano187/Chocolatey-packages/issues?q=author%3ARedBaron2" title="Bug reports">🐛</a></td>
      <td align="center" valign="top" width="20%"><a href="https://github.com/jwfxpr"><img alt="jwfxpr's avatar" crossorigin="anonymous" decoding="sync" height="80" referrerpolicy="strict-origin" src="https://avatars.githubusercontent.com/u/20788820?v=4&s=80" width="80" /><br /><span style="font-weight: 700;">John Reid</span></a><br /><a href="https://github.com/tunisiano187/Chocolatey-packages/commits?author=jwfxpr" title="Code">💻</a></td>
      <td align="center" valign="top" width="20%"><a href="https://youtu.be/_gJdT5Vn11w"><img alt="unusedcow's avatar" crossorigin="anonymous" decoding="sync" height="80" referrerpolicy="strict-origin" src="https://avatars.githubusercontent.com/u/32028105?v=4&s=80" width="80" /><br /><span style="font-weight: 700;">unusedcow</span></a><br /><a href="https://github.com/tunisiano187/Chocolatey-packages/commits?author=unusedcow" title="Code">💻</a></td>
    </tr>
    <tr>
      <td align="center" valign="top" width="20%"><a href="https://github.com/pokepoke81"><img alt="pokepoke81's avatar" crossorigin="anonymous" decoding="sync" height="80" referrerpolicy="strict-origin" src="https://avatars.githubusercontent.com/u/4258646?v=4&s=80" width="80" /><br /><span style="font-weight: 700;">pokepoke81</span></a><br /><a href="https://github.com/tunisiano187/Chocolatey-packages/commits?author=pokepoke81" title="Code">💻</a></td>
      <td align="center" valign="top" width="20%"><a href="https://github.com/NightFurySL2001"><img alt="NightFurySL2001's avatar" crossorigin="anonymous" decoding="sync" height="80" referrerpolicy="strict-origin" src="https://avatars.githubusercontent.com/u/33471049?v=4&s=80" width="80" /><br /><span style="font-weight: 700;">NightFurySL2001</span></a><br /><a href="https://github.com/tunisiano187/Chocolatey-packages/commits?author=NightFurySL2001" title="Code">💻</a></td>
      <td align="center" valign="top" width="20%"><a href="https://github.com/brogers5"><img alt="brogers5's avatar" crossorigin="anonymous" decoding="sync" height="80" referrerpolicy="strict-origin" src="https://avatars.githubusercontent.com/u/6869577?v=4&s=80" width="80" /><br /><span style="font-weight: 700;">Brian Rogers</span></a><br /><a href="https://github.com/tunisiano187/Chocolatey-packages/commits?author=brogers5" title="Code">💻</a></td>
      <td align="center" valign="top" width="20%"><a href="https://github.com/blast007"><img alt="blast007's avatar" crossorigin="anonymous" decoding="sync" height="80" referrerpolicy="strict-origin" src="https://avatars.githubusercontent.com/u/328999?v=4&s=80" width="80" /><br /><span style="font-weight: 700;">Scott Wichser</span></a><br /><a href="#maintenance-blast007" title="Maintenance">🚧</a></td>
      <td align="center" valign="top" width="20%"><a href="https://github.com/RogueScholar"><img alt="RogueScholar's avatar" crossorigin="anonymous" decoding="sync" height="80" referrerpolicy="strict-origin" src="https://avatars.githubusercontent.com/u/15098724?v=4&s=80" width="80" /><br /><span style="font-weight: 700;">Peter J. Mello</span></a><br /><a href="https://github.com/tunisiano187/Chocolatey-packages/commits?author=RogueScholar" title="Code">💻</a> <a href="https://github.com/tunisiano187/Chocolatey-packages/commits?author=RogueScholar" title="Documentation">📖</a> <a href="#maintenance-RogueScholar" title="Maintenance">🚧</a></td>
    </tr>
  </tbody>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

[activity-badge]: https://img.shields.io/github/commit-activity/m/tunisiano187/Chocolatey-packages?style=flat&logo=chocolatey&logoColor=80b5e3&logoSize=auto&label=Commit%20Activity&labelColor=112336&color=seagreen&cacheSeconds=7200
[all-contributors]: https://all-contributors.github.io/overview/ "All Contributors Specification: Overview"
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[all-contributors-badge]: https://img.shields.io/badge/All_Contributors-15-ffe450?style=flat&logo=clubhouse&logoColor=ffe450&logoSize=auto&labelColor=33205c&cacheSeconds=7200
<!-- ALL-CONTRIBUTORS-BADGE:END -->
[automatic-packages]: https://docs.chocolatey.org/en-us/create/automatic-packages/ "Chocolatey Software Documentation: Automatic Packaging"
[chocolatey-au]: /../../../../chocolatey-community/chocolatey-au "chocolatey-community/chocolatey-au: Chocolatey Automatic Package Updater Module"
[codefactor-badge]: https://img.shields.io/codefactor/grade/github/tunisiano187/Chocolatey-packages?style=flat&logo=codefactor&logoColor=f44a6a&logoSize=auto&label=CodeFactor%20Grade&labelColor=242344&color=forestgreen&cacheSeconds=7200
[codefactor-dashboard]: https://www.codefactor.io/repository/github/tunisiano187/chocolatey-packages "CodeFactor.io Overview: tunisiano187/Chocolatey-packages"
[commit-log]: /../../commits/master "Commits"
[contributors-table]: #contributors- "README.md § Contributors ✨"
[emoji-key]: https://all-contributors.github.io/emoji-key/ "All Contributors Specification: Emoji Key ✨ (and Contribution Types)"
[jsdelivr-badge]: https://img.shields.io/jsdelivr/gh/hm/tunisiano187/Chocolatey-packages?style=flat&logo=jsdelivr&logoColor=e84d3d&logoSize=auto&label=jsDelivr&labelColor=19233b&color=f45831&cacheSeconds=7200
[jsdelivr-stats]: https://www.jsdelivr.com/package/gh/tunisiano187/Chocolatey-packages?tab=stats "tunisiano187/Chocolatey-packages CDN by jsDelivr"
[new-ghissue]: /../../../../tunisiano187/Chocolatey-packages/issues/new/choose "Create new issue - Choose an issue template"
[package-list]: Packages.md "List of automatic packages currently maintained here"
[patreon-button]: https://cdn.jsdelivr.net/gh/tunisiano187/Chocolatey-packages@d15c4e19c709e7148588d4523ffc6dd3cd3c7e5e/icons/patreon.png
[patreon-page]: https://patreon.com/tunisiano/about "Patreon: Tunisiano, en train de créer Chocolatey packages"
[pipeline-badge]: https://img.shields.io/appveyor/build/tunisiano187/Chocolatey-packages?style=flat&logo=appveyor&logoColor=2157b6&logoSize=auto&label=Update%20Pipeline&labelColor=fad71b
[pipeline-gist]: https://gist.github.com/tunisiano187/7032dea203873812b435f152ee3794bf#file-update-aupacakges-md "Update-AUPackages Report #powershell #chocolatey"
[tags]: /../../../../tunisiano187/Chocolatey-packages/wiki/Tags.md "Package tags"
[tunisiano-profile]: https://chocolatey.org/profiles/tunisiano "Chocolatey Software: tunisiano"
