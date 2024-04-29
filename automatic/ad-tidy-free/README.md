[![](https://img.shields.io/chocolatey/v/ad-tidy-free?color=green&label=ad-tidy-free)](https://chocolatey.org/packages/ad-tidy-free) [![](https://img.shields.io/chocolatey/dt/ad-tidy-free)](https://chocolatey.org/packages/ad-tidy-free)

## AD Tidy Free Edition (Install)

![Screenshot of AD Tidy](http://www.cjwdev.co.uk/Software/ADTidy/ActionsList.PNG)

####Identify and clean up inactive user and computer accounts in your Active Directory domain
Search your Active Directory domain for user/computer accounts that are no longer in use by filtering based on last logon time, DNS record timestamp, and much more. You can then perform a number of actions on the accounts that were found - such as moving them to another OU, disabling them, setting a random password, removing them from all groups, and much more.

####Features 
* Report on both user and computer accounts 
* Search entire domain or select a specific OU 
* Multi-domain friendly - specify any domain and optionally use alternate credentials to connect to it 
* Get account last logon information from all DCs or select specific DCs (using either lastLogon attribute or lastLogonTimeStamp attribute) 
* Choose to only find accounts that have not logged on for a specified number of days 
* Confirm whether or not computer accounts are still active by using the Ping test and DNS record timestamp check
* Powerful filtering capabilities let you filter results accounts based on name, group membership, expiration date, LDAP attribute, and more
* Export report results to CSV or Excel XLSX file
* Save report settings to file so that you can reload them whenever you want  or share them with colleagues
* Option to reverse actions that were previously performed (Standard Edition only)
* Command line support and Automated Rules allow for automation of account clean up tasks (Standard Edition only)

####For any accounts that are found in the report, you can perform one or more of the following actions:
* Disable 
* Delete 
* Move To Another OU 
* Set Description 
* Set Expiration Date 
* Add To Group 
* Remove From Group 
* Remove From All Groups 
* Hide From Exchange Address Lists 
* Delete home drive 
* Clear LDAP Attribute Value 
* Run External Script
* Set Random Password 
* Disable OWA 
* Set Password To Never Expire 

You can also combine any of these actions into an Action Sequence to speed up common clean up tasks such as disabling accounts and moving them to another OU at the same time. Action sequences can be performed manually on any selected accounts, or by automated rules and command line scripts.		

PACKAGING NOTE: Uninstall through Control Panel.

### Package-specific issue
If this package isn't up-to-date for some days, [Create an issue](https://github.com/tunisiano187/Chocolatey-packages/issues/new/choose)

Support the package maintainer and [![Patreon](https://cdn.jsdelivr.net/gh/tunisiano187/Chocolatey-packages@d15c4e19c709e7148588d4523ffc6dd3cd3c7e5e/icons/patreon.png)](https://www.patreon.com/tunisiano)
