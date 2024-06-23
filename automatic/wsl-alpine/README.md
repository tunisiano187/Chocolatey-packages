[![](https://img.shields.io/chocolatey/v/wsl-alpine?color=green&label=wsl-alpine)](https://chocolatey.org/packages/wsl-alpine) [![](https://img.shields.io/chocolatey/dt/wsl-alpine)](https://chocolatey.org/packages/wsl-alpine)

## Alpine for Windows Subsystem for Linux (WSL) (Install)

___
###[choco://wsl-alpine](choco://wsl-alpine)
To use choco:// protocol URLs, install [(unofficial) choco:// Protocol support ](https://chocolatey.org/packages/choco-protocol-support)
___

###Alpine for Windows Subsystem for Linux (WSL)

Windows S mode currently *NOT* supported.

https://github.com/agowa338/WSL-DistroLauncher-Alpine
Downloads the official Alpine Release.
Checks it's sha256 checksum
Let the windows api extract the tar.gz
Change permissions for / to 755 (non recursive)
Install some prerequirements
Create a useraccount
Drop the user into the Alpine Userland

WSL Alpine DistroLauncher
Introduction
This is the Alpine Launcher implementation for a Windows Subsystem for Linux (WSL) distribution.

Note: This project is written in C++.

Goals
The goal of this project is to enable:

Allow devolopers to use Alpine on their Windows machines for simple tasks (basically everything except kernel modules)
Allow developers to use the WSL with a very low footprint (compared to debian/ubuntu)
Use the official tar.gz userland release without building a custom userland tar.gz
Make the project "self maintained", i.e. don't require to ship any dependencies that require being updated and automatically pull the latest stable userland from the official source (WIP)
Project Status
This project is an active repo maintained by agowa338.


**[PACKAGE NOTES](https://github.com/bcurran3/ChocolateyPackages/blob/master/wsl-alpine/readme.md)**

    

___

Click here to [Patreon-ize](https://www.patreon.com/bcurran3) the package maintainer.
___

#### [choco://wsl-alpine](choco://wsl-alpine)
To use choco:// protocol URLs, install [(unofficial) choco:// Protocol support ](https://chocolatey.org/packages/choco-protocol-support)

### Package-specific issue
If this package isn't up-to-date for some days, [Create an issue](https://github.com/tunisiano187/Chocolatey-packages/issues/new/choose)

Support the package maintainer and [![Patreon](https://cdn.jsdelivr.net/gh/tunisiano187/Chocolatey-packages@d15c4e19c709e7148588d4523ffc6dd3cd3c7e5e/icons/patreon.png)](https://www.patreon.com/tunisiano)
