[![](https://img.shields.io/chocolatey/v/atomicparsley?color=green&label=atomicparsley)](https://chocolatey.org/packages/atomicparsley) [![](https://img.shields.io/chocolatey/dt/atomicparsley)](https://chocolatey.org/packages/atomicparsley)

## AtomicParsley (Portable)

---

### [choco://atomicparsley](choco://atomicparsley)
To use choco:// protocol URLs, install [(unofficial) choco:// Protocol support ](https://chocolatey.org/packages/choco-protocol-support)

---

### AtomicParsley is a lightweight command line program for reading, parsing and setting metadata into MPEG-4 files supporting these styles of metadata:

* iTunes-style metadata into .mp4, .m4a, .m4p, .m4v, .m4b files
* 3gp-style assets (3GPP TS 26.444 version 6.4.0 Release 6 specification conforming) in 3GPP, 3GPP2, MobileMP4 and derivatives
* ISO copyright notices at movie and track level for MPEG-4 and derivative files
* uuid private user extension text and file embedding for MPEG-4 and derivative files

The MPEG-4 container is based on Apple's Quicktime .mov container (just more sane) and there are a number of similarites - as well as differences. Each MPEG-4 file lists a "major file brand" that broadly says which specification the file adheres to. For example, an iTunes audio file typically lists 'M4A ' as its major file brand, while a 3GPP2 .3g2 file has something like '3g2a'. It is based on this major file brand that AtomicParsley allows a style of metadata to be set. Since there is nothing in the 3GPP2 specification regarding iTunes-style metadata, its use is prevented on such files. Similarly, a 3gp 'location' asset is not available for an iTMS video file. The first paragraph here sums the situation up well.

With the exception of artwork, all iTunes-style tags support only 1 piece of metadata - you can't have for example 3 title tags. 3gp assets and copyright notices support multiple tags, but they must differ in the language setting for that tag. You can have for example 3 title tags, but 1 in english, 1 in spanish, 1 in undefined. All iTunes-style text metadata is always in UTF-8; 3gp assets and copyright notices can be in set in UTF-8 or UTF-16. All strings are converted internally to UTF-8, converting as necessary. On *nix platforms, input is in UTF-8; the native Windows port supports full UTF-16 input.

**[PACKAGE NOTES](https://github.com/bcurran3/ChocolateyPackages/blob/master/atomicparsley/readme.md)**
    

---

**Click here to [Patreon-ize](https://www.patreon.com/bcurran3) the package maintainer.**

---

#### [choco://atomicparsley](choco://atomicparsley)
To use choco:// protocol URLs, install [(unofficial) choco:// Protocol support ](https://chocolatey.org/packages/choco-protocol-support)

### Package-specific issue
If this package isn't up-to-date for some days, [Create an issue](https://github.com/tunisiano187/Chocolatey-packages/issues/new/choose)

Support the package maintainer and [![Patreon](https://cdn.jsdelivr.net/gh/tunisiano187/Chocolatey-packages@d15c4e19c709e7148588d4523ffc6dd3cd3c7e5e/icons/patreon.png)](https://www.patreon.com/tunisiano)
