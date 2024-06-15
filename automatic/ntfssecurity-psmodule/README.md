[![](https://img.shields.io/chocolatey/v/ntfssecurity-psmodule?color=green&label=ntfssecurity-psmodule)](https://chocolatey.org/packages/ntfssecurity-psmodule) [![](https://img.shields.io/chocolatey/dt/ntfssecurity-psmodule)](https://chocolatey.org/packages/ntfssecurity-psmodule)

## File System Security PowerShell Module (Install)

Managing permissions with PowerShell is only a bit easier than in VBS or the command line as there are no cmdlets for most day-to-day tasks like getting a permission report or adding permission to an item. PowerShell only offers Get-Acl and Set-Acl but everything in between getting and setting the ACL is missing. This module closes the gap.
 
The module provides 10 cmdlets to manage permissions on the file system, like adding and removing ACEs, setting the inheritance, getting the current permissions or even get the effective permissions for a certain user. The available cmdlets are listed below with a short description. More information can be retreived in the PowerShell using Get-Help.

* Add-NTFSAccess - Adds a specific ace to the current object. 
* Get-NTFSAccess - Gives you a list of all permissions. 
* Get-NTFSOrphanedAccess - Lists all permissions that can no longer be resolved. 
* Remove-NTFSAccess - Removes the permission for a certain account.
* Get-NTFSEffectiveAccess - Shows the permissions an account actually has on a file or folder.
* Get-NTFSInheritance - Shows if inheritance is blocked
* Enable-NTFSInheritance - It can be a problem if certain files or folders on a volume have inheritance disabled. Making sure that inheritance is enabled can be done using this cmdlet
* Disable-NTFSInheritance - see Enable-NTFSInheritance
* Get-NTFSOwner - Shows the owner of a file or folder.
* Set-NTFSOwner - Sets the owner to a specific account.

For documentation please refer to:
[NTFSSecurity Tutorial 1 - Getting, adding and removing permissions](http://blogs.technet.com/b/fieldcoding/archive/2014/12/05/ntfssecurity-tutorial-1-getting-adding-and-removing-permissions.aspx)
[NTFSSecurity Tutorial 2 - Managing NTFS Inheritance and Using Privileges](http://blogs.technet.com/b/fieldcoding/archive/2014/12/05/ntfssecurity-tutorial-2-managing-ntfs-inheritance-and-using-privileges.aspx)

**[PACKAGE NOTES](https://github.com/bcurran3/ChocolateyPackages/blob/master/ntfssecurity-psmodule/readme.md)**

***
**Click here to [Patreon-ize](https://www.patreon.com/bcurran3) the package maintainer.**
***

#### [choco://ntfssecurity-psmodule](choco://ntfssecurity-psmodule)
To use choco:// protocol URLs, install [(unofficial) choco:// Protocol support ](https://chocolatey.org/packages/choco-protocol-support)

### Package-specific issue
If this package isn't up-to-date for some days, [Create an issue](https://github.com/tunisiano187/Chocolatey-packages/issues/new/choose)

Support the package maintainer and [![Patreon](https://cdn.jsdelivr.net/gh/tunisiano187/Chocolatey-packages@d15c4e19c709e7148588d4523ffc6dd3cd3c7e5e/icons/patreon.png)](https://www.patreon.com/tunisiano)
