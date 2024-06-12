[![](https://img.shields.io/chocolatey/v/dotnet-verification-tool?color=green&label=dotnet-verification-tool)](https://chocolatey.org/packages/dotnet-verification-tool) [![](https://img.shields.io/chocolatey/dt/dotnet-verification-tool)](https://chocolatey.org/packages/dotnet-verification-tool)

## .NET Framework Setup Verification Tool (Portable)

##.NET Framework Setup Verification Tool User’s Guide

###Introduction

This .NET Framework setup verification tool is designed to automatically perform a set of steps to verify the installation state of one or more versions of the .NET Framework on a computer.  It will verify the presence of files, directories, registry keys and values for the .NET Framework.  It will also verify that simple applications that use the .NET Framework can be run correctly.

If the verification tool finds any issues, there is a .NET Framework Repair Tool that can be found at the following locations:

http://support.microsoft.com/kb/2698555
http://go.microsoft.com/fwlink/?LinkID=246062
Additional support can be obtained by visiting the .NET Framework setup forum at http://social.msdn.microsoft.com/Forums/en-US/netfxsetup/threads.

By default, the .NET Framework setup verification tool will only list versions of the .NET Framework that it detects are installed on the computer that it is being run on.  As a result, the tool will not list all of the above versions of the .NET Framework.  This product filtering can be overridden by running the .NET Framework setup verification tool with the following command line switch:

netfx_setupverifier.exe /q:a /c:”setupverifier2.exe /a”

#### [choco://dotnet-verification-tool](choco://dotnet-verification-tool)
To use choco:// protocol URLs, install [(unofficial) choco:// Protocol support ](https://chocolatey.org/packages/choco-protocol-support)

### Package-specific issue
If this package isn't up-to-date for some days, [Create an issue](https://github.com/tunisiano187/Chocolatey-packages/issues/new/choose)

Support the package maintainer and [![Patreon](https://cdn.jsdelivr.net/gh/tunisiano187/Chocolatey-packages@d15c4e19c709e7148588d4523ffc6dd3cd3c7e5e/icons/patreon.png)](https://www.patreon.com/tunisiano)
