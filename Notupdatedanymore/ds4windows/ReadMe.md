[![](https://img.shields.io/chocolatey/v/ds4windows?color=green&label=ds4windows)](https://chocolatey.org/packages/ds4windows) [![](https://img.shields.io/chocolatey/dt/ds4windows)](https://chocolatey.org/packages/ds4windows)


## DS4Windows

Like those other DS4 tools, but sexier.

DS4Windows is an extract anywhere program that allows you to get the best
DualShock 4 experience on your PC. By emulating an Xbox 360 controller, many
more games are accessible. Other input controllers are also supported including the
DualSense, Switch Pro, and JoyCon controllers (**first party hardware only**).

![DS4Windows Preview](https://raw.githubusercontent.com/Ryochan7/DS4Windows/jay/ds4winwpf_screen_20200412.png)

### Requirements

- Windows 10 or newer (Thanks Microsoft)
- [Microsoft .NET 6.0 Desktop Runtime](https://dotnet.microsoft.com/en-us/download/dotnet/6.0/runtime)
- Visual C++ 2015-2019 Redistributable. [x64](https://aka.ms/vs/16/release/vc_redist.x64.exe) or [x86](https://aka.ms/vs/16/release/vc_redist.x86.exe)
- [ViGEmBus](https://vigem.org/) driver (DS4Windows will install it for you)
- Microsoft 360 Driver (link inside DS4Windows, already installed by Windows if
you've used a 360 controller before)
- Sony DualShock 4 or other supported controller
- Connection method:
  - Micro USB cable
  - [Sony Wireless Adapter](https://www.amazon.com/gp/product/B01KYVLKG2)
  - Bluetooth 4.0 (via an
[adapter like this](https://www.newegg.com/Product/Product.aspx?Item=N82E16833166126)
or built in pc). Only use of Microsoft BT stack is supported. CSR BT stack is
confirmed to not work with the DS4 even though some CSR adapters work fine
using Microsoft BT stack. Toshiba's adapters currently do not work. 
*Disabling 'Enable output data' in the controller profile settings might help with latency issues, but will disable lightbar and rumble support.*
- Disable **PlayStation Configuration Support** and
**Xbox Configuration Support** options in Steam

### Package-specific issue
If this package isn't up-to-date for some days, [Create an issue](https://github.com/tunisiano187/Chocolatey-packages/issues/new/choose)

Support the package maintainer and [![Patreon](https://cdn.jsdelivr.net/gh/tunisiano187/Chocolatey-packages@d15c4e19c709e7148588d4523ffc6dd3cd3c7e5e/icons/patreon.png)](https://www.patreon.com/bePatron?u=39585820)
