[![](https://img.shields.io/chocolatey/v/password-control?color=green&label=password-control)](https://chocolatey.org/packages/password-control) [![](https://img.shields.io/chocolatey/dt/password-control)](https://chocolatey.org/packages/password-control)

## Password Control (Install)

![Screenshot of Password Control](http://www.wisesoft.co.uk/Products/PasswordControl/Images/enabled_user.PNG)

###Overview

Password Control is a tool designed to allow helpdesk staff and other IT support personnel to reset user passwords.  It has a simple and intuitive interface that many users find more productive than a custom MMC console.  Password Control is designed to work with **Active Directory** based domains.  It also features other functions such as the ability to enable and disable user accounts (you can edit a config file to remove these features if required). 

The "G" button shown in the screenshot above (next to the password box) is used to generate random passwords.  By default the generated password will contain a random combination of upper case and lower case characters and digits.  Symbols can also be included and you can alter the length of the password generated above that of your minimum password length setting.  You can also choose to use a "pass phrase" or a custom password mask.  A pass phrase is simply a combination of two words seperated by a space. A mask gives you the ability to set the exact format of the password. e.g. 5 lowercase characters followed by 2 digits, A random word followed by 3 digits, a specific password etc.

Please read [this](http://www.wisesoft.co.uk/software/passwordcontrol/basics.aspx) document to help you get started.

###Features

* Enable/Disable Accounts.
* Password Reset with automatic account unlock.
* Password Generation.  A random password can be generated of a specified length with the option of uppercase, lowercase, digits and symbols.  A pass phrase can also be used or you can specify a custom mask for generating passwords.
* Unlock user accounts.
* Change various account options. e.g. "Password Never Expires", "User must change password at next logon" etc
* Connect As Feature - Quick and easy method of running Password Control as a user with enhanced privileges.
* Multi-Domain support. The domain can easily be changed using the menu and the domain list is built automatically from the trusted domains in your enterprise. You can also add additional domains by hand or configure Password Control so that is connects to a specific domain controller. By default, Password Control will connect to any available domain controller in the current domain, but this behavior can easily be changed.
* Searching capabilities - Easy to search for user accounts when the account name is not known.  A sinple search feature is included to search for users based on a combination of firstname and surname.  An advanced search feature is also included that reuses the existing Microsoft object search dialog with which you are probably already familiar.
* Ability to customize which properties are displayed for user accounts. Display virtually any attribute.
* Domain Policy - A quick method to determine which password policy settings are defined for your domain.
* Extensible design - additional features can be added with scripts.
* Picture Gallery feature for users storing photos in Active Directory.
* Bulk Password Control for changing Passwords for many user accounts. Note: this feature will be part of a separate application called Bulk AD Users in the next release. 
* Bulk Modify for changing attributes of many user accounts. Note: this feature will be part of a separate application called Bulk AD Users in the next release. 

**[PACKAGE NOTES](https://github.com/bcurran3/ChocolateyPackages/blob/master/password-control/readme.md)**

#### [choco://password-control](choco://password-control)
To use choco:// protocol URLs, install [(unofficial) choco:// Protocol support ](https://chocolatey.org/packages/choco-protocol-support)

### Package-specific issue
If this package isn't up-to-date for some days, [Create an issue](https://github.com/tunisiano187/Chocolatey-packages/issues/new/choose)

Support the package maintainer and [![Patreon](https://cdn.jsdelivr.net/gh/tunisiano187/Chocolatey-packages@d15c4e19c709e7148588d4523ffc6dd3cd3c7e5e/icons/patreon.png)](https://www.patreon.com/bePatron?u=39585820)
