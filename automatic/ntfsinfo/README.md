[![](https://img.shields.io/chocolatey/v/ntfsinfo?color=green&label=ntfsinfo)](https://chocolatey.org/packages/ntfsinfo) [![](https://img.shields.io/chocolatey/dt/ntfsinfo)](https://chocolatey.org/packages/ntfsinfo)

## ntfsinfo
NTFSInfo is a little applet that shows you information about NTFS volumes. Its dump includes the size of a drive's allocation
units, where key NTFS files are located, and the sizes of the NTFS metadata files on the volume. This information is typically
of little more than curiosity value, but NTFSInfo does show some interesting things. For example, you've probably heard about
the NTFS equivalent of the FAT file system's File Allocation Table. Its called the Master File Table (MFT), and it is made up
of constant sized records that describe the location of all the files and directories on the drive. What's surprising about the
MFT is that it is managed as a file, just like any other. NTFSInfo will show you where on the disk (in terms of clusters) the
MFT is located and how large it is, in addition to specifying how large the volume's clusters and MFT records are. In order to
protect the MFT from fragmentation, NTFS reserves a portion of the disk around the MFT that it will not allocate to other files
unless disk space runs low. This area is known as the MFT-Zone and NTFSInfo will tell you where on the disk the MFT-Zone is
located and what percentage of the drive is reserved for it.

### Package-specific issue
If this package isn't up-to-date for some days, [Create an issue](https://github.com/tunisiano187/Chocolatey-packages/issues/new/choose)

Support the package maintainer and [![Patreon](https://cdn.jsdelivr.net/gh/tunisiano187/Chocolatey-packages@d15c4e19c709e7148588d4523ffc6dd3cd3c7e5e/icons/patreon.png)](https://www.patreon.com/bePatron?u=39585820)
