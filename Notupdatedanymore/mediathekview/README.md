# MediathekView

Chocolatey package for MediathekView, a tool to browse and download the Mediathek of various German public broadcasters.

## Description

MediathekView allows you to browse and download media content from German public broadcasters including:
- ARD
- ZDF
- WDR
- BR
- NDR
- SWR
- MDR
- HR
- RBB
- SR
- KiKA
- 3sat
- arte
- ORF
- SRF
- RTS

## Package Information

- **Package Name**: mediathekview
- **Version**: 14.5.0
- **Type**: Automatic (updated daily via AU)
- **Installer**: Windows executable (silent install supported)

## Usage

```powershell
choco install mediathekview
```

## Updates

This package is automatically updated daily using the Chocolatey AU (Automatic Updater) module. The update script:
1. Checks the official MediathekView download page for the latest version
2. Downloads the installer and calculates the checksum
3. Updates the package metadata and installation script
4. Performs VirusTotal scanning for security

## Notes

- The package installs MediathekView silently with the `/S` flag
- The application is portable and doesn't require additional setup
- Updates are coordinated through the Chocolatey AU system
