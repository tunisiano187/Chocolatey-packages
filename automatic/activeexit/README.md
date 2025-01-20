[![](https://img.shields.io/chocolatey/v/activeexit?color=green&label=activeexit)](https://chocolatey.org/packages/activeexit) [![](https://img.shields.io/chocolatey/dt/activeexit)](https://chocolatey.org/packages/activeexit)

## ActiveExit (Install)

![Screenshot of ActiveExit](http://www.winability.com/screenshots/active-exit.png)

ActiveExit™ is a system utility that can automatically log off users from their accounts after a period of inactivity. If you are a system administrator and users of your network often forget to log off before leaving, ActiveExit can save you quite a bit of your nerve cells. Even if the user has locked the computer, ActiveExit can log the user off after the idle period you specify, without your intervention.

If you manage a large network of computers using Active Directory and Group Policy, you can use ActiveExit to edit a Group Policy Object (GPO) to manage all network computers from one central location on the server.

## What can ActiveExit do for you?

### Log off the inactive users automatically

When ActiveExit is enabled, it is monitoring the user activity: the keyboard, the mouse, and (optionally) the CPU. If no user activity has been detected during the time interval of your choosing, ActiveExit displays a message to the user (for the duration of your choosing, too). If no user activity detected after that, ActiveExit forcefully logs off that user from Windows.

### Log off the inactive users even if they locked their screens

Unlike WINEXIT and other similar utilities, ActiveExit can log off the inactive users even if the users locked their screens before leaving. (The administrator will no longer have to unlock the screens manually each time it happens).

### Log off the inactive users even if they set up custom screen savers

Unlike WINEXIT and other similar software utilities, ActiveExit does not replace the screensaver of the user with its own. If fact, ActiveExit does not depend on the Windows screensaver functionality at all: each user is welcome to choose any screen saver or none at all, ActiveExit will work just the same.

### Log off the inactive users even if they have unsaved changes

This is a powerful feature of ActiveExit that you should consider carefully. Normally, if a user attempts to log off while there are unsaved changes to the documents, Windows prompts the user to save the changes before logging off. With ActiveExit, the automatic log off happens unconditionally, even if there are changes still unsaved by the user. The unsaved changes, if any, will be lost and the user will be logged off.

### Shut down, sleep, or hibernate the inactive computers

After the last user has logged off, if no one logs back on to the computer during the interval of your choosing, ActiveExit can shut the computer down, sleep, or hibernate it.

#### [choco://activeexit](choco://activeexit)
To use choco:// protocol URLs, install [(unofficial) choco:// Protocol support ](https://chocolatey.org/packages/choco-protocol-support)

### Package-specific issue
If this package isn't up-to-date for some days, [Create an issue](https://github.com/tunisiano187/Chocolatey-packages/issues/new/choose)

Support the package maintainer and [![Patreon](https://cdn.jsdelivr.net/gh/tunisiano187/Chocolatey-packages@d15c4e19c709e7148588d4523ffc6dd3cd3c7e5e/icons/patreon.png)](https://www.patreon.com/bePatron?u=39585820)
