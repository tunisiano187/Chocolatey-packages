[![](https://img.shields.io/chocolatey/v/vigembus?color=green&label=vigembus)](https://chocolatey.org/packages/vigembus) [![](https://img.shields.io/chocolatey/dt/vigembus)](https://chocolatey.org/packages/vigembus)

## ViGEm Bus Driver

The `ViGEmBus` driver and `ViGEmClient` libraries represent the core of the Virtual Gamepad Emulation Framework (or `ViGEm` , for short). `ViGEm` aims for a 100% accurate [emulation](<https://en.wikipedia.org/wiki/Emulator>) of well-known gaming peripherals as pure software-based devices at kernel level. As it mimics "the real thing" games and other processes require no additional modification whatsoever to detect `ViGEm`-based devices (no Proxy-DLLs or API-Hooking) and simply work out of the box. While the (now obsolete) [Scarlett.Crush Productions Virtual Bus Driver](<https://github.com/nefarius/ScpVBus>) is the spiritual father of this project, `ViGEm` has been designed and written from the ground up utilizing Microsoft's [Kernel-Mode Driver Framework](https://en.wikipedia.org/wiki/Kernel-Mode_Driver_Framework).

#### Emulated devices

Currently supports emulation of the following USB Gamepads:

- [Microsoft Xbox 360 Controller](https://en.wikipedia.org/wiki/Xbox_360_controller)
- [Sony DualShock 4 Controller](https://en.wikipedia.org/wiki/DualShock#DualShock_4)

### Supported Systems

The driver is built for Windows 10/11, Server 2016, and Server 2019 only (x86 and amd64).

### Package-specific issue
If this package isn't up-to-date for some days, [Create an issue](https://github.com/tunisiano187/Chocolatey-packages/issues/new/choose)

Support the package maintainer and [![Patreon](https://cdn.jsdelivr.net/gh/tunisiano187/Chocolatey-packages@d15c4e19c709e7148588d4523ffc6dd3cd3c7e5e/icons/patreon.png)](https://www.patreon.com/bePatron?u=39585820)
