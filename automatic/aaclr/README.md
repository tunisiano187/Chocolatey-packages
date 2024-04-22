[![](https://img.shields.io/chocolatey/v/aaclr?color=green&label=aaclr)](https://chocolatey.org/packages/aaclr) [![](https://img.shields.io/chocolatey/dt/aaclr)](https://chocolatey.org/packages/aaclr)

## Auto Aero Colors (AAClr)

Windows 8 has a new feature where the Aero colors can be automatically adjusted according to the selected wallpaper.

This seems to be a nice feature, and there's even a tool available that offers that feature for Windows 7: Aura.

But there are some things about Aura that bother me, so I hacked together my own tool which offers that feature.

Unlike Aura, AAClr is written in plain C++ and doesn't use the .NET Framework. For tools that are supposed to be started automatically on logon, this ensures that the whole startup time doesn't increase by several seconds.

AAClr also detects changes in wallpapers by catching events from the system and doesn't use timers that access the wallpaper file several times a second (like Aura does). That means that AAClr is idle most of the time and only wakes up when necessary.

And about resource usage: AAClr uses less than 2MB of private bytes - I think that's not too much.

[Source code](https://code.google.com/p/stexbar/source/browse/#svn%2Ftrunk%2FMisc%2FAAClr)

### Package-specific issue
If this package isn't up-to-date for some days, [Create an issue](https://github.com/tunisiano187/Chocolatey-packages/issues/new/choose)

Support the package maintainer and [![Patreon](https://cdn.jsdelivr.net/gh/tunisiano187/Chocolatey-packages@d15c4e19c709e7148588d4523ffc6dd3cd3c7e5e/icons/patreon.png)](https://www.patreon.com/tunisiano)
