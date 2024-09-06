[![](https://img.shields.io/chocolatey/v/tdarr-updater?color=green&label=tdarr-updater)](https://chocolatey.org/packages/tdarr-updater) [![](https://img.shields.io/chocolatey/dt/tdarr-updater)](https://chocolatey.org/packages/tdarr-updater)

## Tdarr Updater (Portable)

---

### [choco://tdarr-updater](choco://tdarr-updater)
To use choco:// protocol URLs, install [(unofficial) choco:// Protocol support ](https://chocolatey.org/packages/choco-protocol-support)

---

![Screenshot of tdarr-updater](https://cdn.jsdelivr.net/gh/tunisiano187/Chocolatey-packages@master/automatic/tdarr-updater/tdarr-updater_screenshot.png?raw=true)


**Tdarr Updater** will automatically download and extract the latest version of Tdarr V2: Distributed Transcoding System; server and node.

Tdarr V2 is a cross-platform conditional based transcoding application for automating media library transcode/remux management in order to process your media files as required. For example, you can set rules for the required codecs, containers, languages etc that your media should have which helps keeps things organized and can increase compatability with your devices. A common use for Tdarr is to simply convert video files from h264 to h265 (hevc), saving 40%-50% in size.

The application is in the form of a click-to-run web-app, comprised of the following 2 components:

* Tdarr_Server - Central process which all Nodes connect with
* Tdarr_Node - Processes running on same/other devices which collect tasks from the Server

Put your spare hardware to use with Tdarr Nodes for Windows, Linux (including Linux arm/arm64) and macOS.

Designed to work alongside applications like Sonarr/Radarr and built with the aim of modularisation, parallelisation and scalability, each library you add has its own transcode settings, filters and schedule. Workers can be fired up and closed down as necessary, and are split into 4 types - Transcode CPU/GPU and Health Check CPU/GPU. Worker limits can be managed by the scheduler as well as manually. For a desktop application with similar functionality please see [HBBatchBeast](https://community.chocolatey.org/packages/hbbatchbeast).

(More information on the website)


---

### Package-specific issue
If this package isn't up-to-date for some days, [Create an issue](https://github.com/tunisiano187/Chocolatey-packages/issues/new/choose)

Support the package maintainer and [![Patreon](https://cdn.jsdelivr.net/gh/tunisiano187/Chocolatey-packages@d15c4e19c709e7148588d4523ffc6dd3cd3c7e5e/icons/patreon.png)](https://www.patreon.com/bePatron?u=39585820)

---
