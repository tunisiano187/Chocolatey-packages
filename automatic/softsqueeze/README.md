[![](https://img.shields.io/chocolatey/v/softsqueeze?color=green&label=softsqueeze)](https://chocolatey.org/packages/softsqueeze) [![](https://img.shields.io/chocolatey/dt/softsqueeze)](https://chocolatey.org/packages/softsqueeze)

## softsqueeze

![Screenshot of softsqueeze](http://ftparmy.com/images/softsqueeze-02.jpg)
	
Softsqueeze is a music player for your PC that works with the Squeezebox Server (Logitech Media Server v7.4+) software. It complements the Boom, Duet, Transporter, Squeezebox and Slimp3 hardware music players developed by Slim Devices.


Supports synchronization with hardware players and remote streaming over the Internet using ssh tunneling.


Developed in Java, allowing this useful application to work with Windows PCs, OS X and Unix systems.


Emulates most of the digital music players and uses the TCP based slim protocol, allowing use across the Internet and through firewalls/NAT routers.


#####Features:
+ Audio Playback
	Native playback of Flac, MP3, WAV and AIFF audio.
	Support for Ogg Vorbis, WMA and AAC by transcoding in SqueezeCenter.
	Gapless playback for most audio formats.
	Synchronization with Squeezebox2, Squeezebox and Slimp3 (requires Java 1.5)
	Pause, volume control and mute buttons.
	Supports Windows Direct Sound on a Windows PC.


+ Squeezebox2 Graphics Support
	Emulation of the new 320x32 graphic display.
	Full support for all Squeezebox fonts.
	Spectrum Analyzer, VU meters.

+ Skins
	Slim Devices skin with horizontal or vertical remotes.
	Excession and Excession Large skins.
	LCD skin, designed for use on laptop computers.
	Quick link to slim server web interface
	Window snapping
	Also supports headless operation
+ Music search and playlist editor


+ Emulation of Slim IR Remote control
	Button auto repeat (for example press and hold pause stop's the player)
	Keyboard shortcuts for common remote control functions (uses the same keys as winamp and xmms).
+ Slim Protocol
	Supports Slim Server version 6.0 upwards.
	Support for password encrypted servers.
	Auto reconnection to Slim Server when connection is lost.
	Built-in ssh tunneling support for remote connections.
	Slim server discovery.

There are versions of softsqueeze for OS X, Android, and iPhone. Together with Logitech Media Server you can control music playback to all your devices.

"choco install logitech-media-server" to install the server software.

####PACKAGING NOTES: This will download the program and make an icon on your desktop. It does not actually "install."  Version 3.9b2 02-24-2011 (latest - no final release)

#### [choco://softsqueeze](choco://softsqueeze)
To use choco:// protocol URLs, install [(unofficial) choco:// Protocol support ](https://chocolatey.org/packages/choco-protocol-support)

### Package-specific issue
If this package isn't up-to-date for some days, [Create an issue](https://github.com/tunisiano187/Chocolatey-packages/issues/new/choose)

Support the package maintainer and [![Patreon](https://cdn.jsdelivr.net/gh/tunisiano187/Chocolatey-packages@d15c4e19c709e7148588d4523ffc6dd3cd3c7e5e/icons/patreon.png)](https://www.patreon.com/tunisiano)
