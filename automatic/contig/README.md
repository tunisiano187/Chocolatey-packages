[![](https://img.shields.io/chocolatey/v/contig?color=green&label=contig)](https://chocolatey.org/packages/contig) [![](https://img.shields.io/chocolatey/dt/contig)](https://chocolatey.org/packages/contig)

## Contig

Wish you could quickly defragment your frequently used files? Use Contig to optimize individual files, or to create new files that are contiguous.

There are a number of NT disk defraggers on the market, including Winternals Defrag Manager. These tools are useful for performing a general defragmentation of disks, but while most files are defragmented on drives processed by these utilities, some files may not be. In addition, it is difficult to ensure that particular files that are frequently used are defragmented - they may remain fragmented for reasons that are specific to the defragmentation algorithms used by the defragging product that has been applied. Finally, even if all files have been defragmented, subsequent changes to critical files could cause them to become fragmented. Only by running an entire defrag operation can one hope that they might be defragmented again.

#### Command line usage

__\src\Contig\Release\Contig.exe__ [__-a__] [__-s__] [__-q__] [__-v__] [existing file]

__\src\Contig\Release\Contig.exe__ [__-f__] [__-q__] [__-v__] [drive:]

__\src\Contig\Release\Contig.exe__ [__-v__] [__-l__] __-n__ [new file] [new file length]

__-a__  Analyze fragmentation

__-f__  Analyze free space fragmentation

__-l__  Set valid data length for quick file creation (requires administrator rights)

__-q__  Quiet mode

__-s__  Recurse subdirectories

__-v__  Verbose

### Package-specific issue
If this package isn't up-to-date for some days, [Create an issue](https://github.com/tunisiano187/Chocolatey-packages/issues/new/choose)

Support the package maintainer and [![Patreon](https://cdn.jsdelivr.net/gh/tunisiano187/Chocolatey-packages@d15c4e19c709e7148588d4523ffc6dd3cd3c7e5e/icons/patreon.png)](https://www.patreon.com/tunisiano)
