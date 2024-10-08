[![](https://img.shields.io/chocolatey/v/osfmount?color=green&label=osfmount)](https://chocolatey.org/packages/osfmount) [![](https://img.shields.io/chocolatey/dt/osfmount)](https://chocolatey.org/packages/osfmount)

## OSFMount (Install)

![Screenshot of OSFMount](https://www.osforensics.com/img/osfmount-mainscreenshot%201.png)

OSFMount is a free utility designed for use with [PassMark OSForensics](https://www.osforensics.com/index.html)™

## Overview

OSFMount allows you to mount local disk image files (bit-for-bit copies of an entire disk or disk partition) in Windows as a physical disk or a logical drive letter. You can then analyze the disk image file with [PassMark OSForensics](https://www.osforensics.com/index.html)™ by using the physical disk name (eg. \\.\PhysicalDrive1) or logical drive letter (eg. Z:).

By default, the image files are mounted as read only so that the original image files are not altered.

OSFMount supports mounting disk image files as read/write in "write cache" mode. This stores all writes to a "write cache" (or "delta") file which preserves the integriy of the original disk image file.

OSFMount also supports the creation of RAM disks, basically a disk mounted into RAM. This generally has a large speed benefit over using a hard disk. As such this is useful with applications requiring high speed disk access, such a database applications, games (such as game cache files) and browsers (cache files). A second benefit is security, as the disk contents are not stored on a physical hard disk (but rather in RAM) and on system shutdown the disk contents are not persistent. At the time of writing, we believe this is the fastest RAM drive software available.

OSFMount supports mounting images of CDs in .ISO format , which can be useful when a particular CD is used often and the speed of access is important.

#### [choco://osfmount](choco://osfmount)
To use choco:// protocol URLs, install [(unofficial) choco:// Protocol support ](https://chocolatey.org/packages/choco-protocol-support)

### Package-specific issue
If this package isn't up-to-date for some days, [Create an issue](https://github.com/tunisiano187/Chocolatey-packages/issues/new/choose)

Support the package maintainer and [![Patreon](https://cdn.jsdelivr.net/gh/tunisiano187/Chocolatey-packages@d15c4e19c709e7148588d4523ffc6dd3cd3c7e5e/icons/patreon.png)](https://www.patreon.com/bePatron?u=39585820)
