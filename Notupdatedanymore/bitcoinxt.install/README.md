[![](https://img.shields.io/chocolatey/v/bitcoinxt.install?color=green&label=bitcoinxt.install)](https://chocolatey.org/packages/bitcoinxt.install) [![](https://img.shields.io/chocolatey/dt/bitcoinxt.install)](https://chocolatey.org/packages/bitcoinxt.install)

## Bitcoin XT (Not mainained anymore)
Bitcoin XT is an implementation of a Bitcoin full node, based upon the source code of Bitcoin Core with a focus on upgrades to the peer to peer protocol. By running it you can opt in to providing the Bitcoin network with additional services beyond what Bitcoin Core provides, including [bigger blocks](https://bitcoinxt.software/#sec-hardfork).

It is built by taking the latest stable Core release, applying a series of [patches](https://github.com/bitcoinxt/bitcoinxt/releases), and then doing deterministic builds so anyone can check the downloads correspond to the source code.

### Known issues
Virus detection : [More info](https://github.com/bitcoinxt/bitcoinxt/issues/520)

### Disk Requirements
* Size increases based on quantity of transactions ([growth chart](https://blockchain.info/charts/blocks-size))
* Blockchain is slowly downloaded only when Bitcoin XT is running and connected to network
* Blockchain default location is `%AppData%\Bitcoin\data`
* Bitcoin XT uses the same data directories as Bitcoin Core so either program can use the same blockchain data.

### Security
* This program should only be installed on a trusted machine.
* By default, upon first execution Bitcoin XT creates an unencrypted wallet file at `%AppData%\Bitcoin\wallet.dat`
* Wallet.dat stores all your private keys for public Bitcoin addresses.  If this file is not encrypted, anyone with access to the file may withdraw funds from addresses stored in the file.  For this reason, you should encrypt wallet.dat as soon as possible from the Bitcoin XT interface.
* After encrypting wallet.dat, back up wallet.dat to at least one other secure storage medium.
* More information about [securing your wallet](https://bitcoin.org/en/secure-your-wallet)

### Package-specific issue
If this package isn't up-to-date for some days, [Create an issue](https://github.com/tunisiano187/Chocolatey-packages/issues/new/choose)

[![Patreon](https://cdn.jsdelivr.net/gh/tunisiano187/Chocolatey-packages@d15c4e19c709e7148588d4523ffc6dd3cd3c7e5e/icons/patreon.png)](https://www.patreon.com/bePatron?u=39585820)
