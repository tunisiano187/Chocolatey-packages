[![](https://img.shields.io/chocolatey/v/hfsexplorer?color=green&label=hfsexplorer)](https://chocolatey.org/packages/hfsexplorer) [![](https://img.shields.io/chocolatey/dt/hfsexplorer)](https://chocolatey.org/packages/hfsexplorer)

## HFSExplorer (Install)

---

### [choco://hfsexplorer](choco://hfsexplorer)
To use choco:// protocol URLs, install [(unofficial) choco:// Protocol support ](https://chocolatey.org/packages/choco-protocol-support)

---

![Screenshot of HFSExplorer](https://cdn.staticaly.com/gh/bcurran3/ChocolateyPackages/master/hfsexplorer/hfsexplorer_screenshot.png)

What is HFSExplorer?

HFSExplorer is an application that can read Mac-formatted hard disks and disk images.
It can read the file systems HFS (Mac OS Standard), HFS+ (Mac OS Extended) and HFSX (Mac OS Extended with case sensitive file names).

HFSExplorer allows you to browse your Mac volumes with a graphical file system browser, extract files (copy to hard disk), view detailed information about the volume and create disk images from the volume.
HFSExplorer can also read most .dmg / .sparsebundle disk images created on a Mac, including zlib / bzip2 compressed images and AES-128 / AES-256 encrypted images. It supports the partition schemes Master Boot Record, GUID Partition Table and Apple Partition Map natively.

You may be interested in the application if you're:

A user of an Intel Mac running Windows with Boot Camp in need of accessing the files on the Mac OS X hard drive.
Owners of HFS+-formatted iPods, that wish to access their content from within Windows or elsewhere (a user emailed me and verified that this works).
Users of PearPC or similar Mac emulation/virtualization software that wish to access the contents of their virtual hard disks (will only work if the disk image is stored in raw format, as in PearPC).
People that need to access the contents of HFS+-formatted .dmg / .sparsebundle files.
HFSExplorer is written mostly in Java 5, optionally using some Java 6 / 7 features, with some Windows-specific parts written in C in order to be able to get raw access to block devices, and to create a practical launcher application.

Linux and OS X users should in most cases not need HFSExplorer for browsing file systems on devices, since there are native file system drivers available on those systems, but it seems to work fine if you need it. Linux users might find use for opening .dmg / .sparsebundle files.
NOTE: HFSExplorer will install silently but will not uninstall silently. A window will pop up asking if you want to remove the program. A forced reinstall will run the uninstall, causing same.
    
**[PACKAGE NOTES](https://github.com/bcurran3/ChocolateyPackages/blob/master/hfsexplorer/readme.md)**

---

**Click here to [Patreon-ize](https://www.patreon.com/bcurran3) the package maintainer.**

---

#### [choco://hfsexplorer](choco://hfsexplorer)
To use choco:// protocol URLs, install [(unofficial) choco:// Protocol support ](https://chocolatey.org/packages/choco-protocol-support)

### Package-specific issue
If this package isn't up-to-date for some days, [Create an issue](https://github.com/tunisiano187/Chocolatey-packages/issues/new/choose)

Support the package maintainer and [![Patreon](https://cdn.jsdelivr.net/gh/tunisiano187/Chocolatey-packages@d15c4e19c709e7148588d4523ffc6dd3cd3c7e5e/icons/patreon.png)](https://www.patreon.com/tunisiano)
