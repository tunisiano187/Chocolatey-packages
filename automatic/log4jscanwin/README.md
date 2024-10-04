[![](https://img.shields.io/chocolatey/v/log4jscanwin?color=green&label=log4jscanwin)](https://chocolatey.org/packages/log4jscanwin) [![](https://img.shields.io/chocolatey/dt/log4jscanwin)](https://chocolatey.org/packages/log4jscanwin)

## Qualys Log4j Vulnerability Scanner (Portable)

---

### [choco://log4jscanwin](choco://log4jscanwin)
To use choco:// protocol URLs, install [(unofficial) choco:// Protocol support ](https://chocolatey.org/packages/choco-protocol-support)

---

The Log4jScanner.exe utility helps to detect CVE-2021-44228 and CVE-2021-45046 vulnerabilities. The utility will scan the entire hard drive(s) including archives (and nested JARs) for the Java class that indicates the Java application contains a vulnerable log4j library. The utility will output its results to a console.

Qualys has added a new QID (376160) that is designed to look for the results of this scan and mark the asset as vulnerable if the vulnerable log4j library was found.

Qualys customers should use the following to run the tool on any asset they want to scan:

Log4jScanner.exe /scan /report_sig

**[PACKAGE NOTES](https://github.com/bcurran3/ChocolateyPackages/blob/master/log4jscanwin/readme.md)**

***
**Click here to [Patreon-ize](https://www.patreon.com/bcurran3) the package maintainer.**
***

#### [choco://log4jscanwin](choco://log4jscanwin)
To use choco:// protocol URLs, install [(unofficial) choco:// Protocol support ](https://chocolatey.org/packages/choco-protocol-support)

### Package-specific issue
If this package isn't up-to-date for some days, [Create an issue](https://github.com/tunisiano187/Chocolatey-packages/issues/new/choose)

Support the package maintainer and [![Patreon](https://cdn.jsdelivr.net/gh/tunisiano187/Chocolatey-packages@d15c4e19c709e7148588d4523ffc6dd3cd3c7e5e/icons/patreon.png)](https://www.patreon.com/bePatron?u=39585820)
