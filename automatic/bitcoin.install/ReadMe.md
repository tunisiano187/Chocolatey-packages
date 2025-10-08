[![](https://img.shields.io/chocolatey/v/bitcoin.install?color=green&label=bitcoin.install)](https://chocolatey.org/packages/bitcoin.install) [![](https://img.shields.io/chocolatey/dt/bitcoin.install)](https://chocolatey.org/packages/bitcoin.install)

## Bitcoin Wallet
Bitcoin uses decentralized, peer-to-peer technology to operate a public transactional database with no
central authority or banks; managing transactions and the issuing of value units, called "bitcoins", is
carried out collectively by the network. Bitcoin is open-source; its design is public, nobody owns or
controls Bitcoin and everyone can take part. Through many of its unique properties, Bitcoin allows
exciting uses that could not be covered by any previous payment system.

All transactions executed upon the Bitcoin network are public record. Bitcoin Core wallet allows
creating private addresses, sending funds to private addresses, and synchronization of any private
addresses that have received transactions. Bitcoin Core does this by reading the locally stored public
ledger called the blockchain, and populating the user interface with these pertinent details. Bitcoin
Core wallet will thus download a full copy of the distributed ledger to your computer and keep it
updated. It will also keep it verified by comparing recent block data with block data of network nodes.
A block chain is a transaction database containing all private addresses that have ever received a
transaction. The database is shared by all nodes participating in a system based on the Bitcoin
protocol. A full copy of a currency's block chain contains every transaction ever executed in the
currency. With this information, one can find out how much value belonged to each address at any point
in history.

New transactions are approved by computing a value determined dynamically by recent conditions of the
Bitcoin network which satisfy conditions specified within the Bitcoin protocol. The Bitcoin protocol can
only be modified by adjusting over 50% of currently running nodes, or in other words, upgrading to a new
version. Most upgrades only modify the user interface and make no changes to the Bitcoin protocol. In
the rare event a Bitcoin protocol update has been mandated, called a "hard fork", all software nodes
that utilizes the Bitcoin blockchain must be upgraded by a certain date.

#### Disk Requirements
As of 01 April 2024, the total size of the BTC blockchain is nearly 600 GB
Size increases based on quantity of transactions ([growth chart](https://blockchain.info/charts/blocks-size))   
Blockchain is slowly downloaded only when Bitcoin Core is running and connected to network
Blockchain default location is %AppData%\Bitcoin\data
Security   
This program should only be installed on a trusted machine.
By default, upon first execution Bitcoin Core creates an unencrypted wallet file at
%AppData%\Bitcoin\wallet.dat   
Wallet.dat stores all your private keys for public Bitcoin addresses. If this file is not encrypted,
anyone with access to the file may withdraw funds from addresses stored in the file. For this reason,
you should encrypt the file as soon as possible with Bitcoin Core.   
After encrypting wallet.dat, back up wallet.dat to at least one other storage medium.
More information about securing your wallet

#### Community
[Forums](https://bitcoin.org/en/community#forums)   
[IRC](https://bitcoin.org/en/community#irc)   
[Social media](https://bitcoin.org/en/community#social)   

#### Documentation
[FAQ](https://bitcoin.org/en/faq)   
[Wiki](http://en.bitcoin.it/)   
[How to use](https://bitcoin.org/en/getting-started)   
[How it works](https://bitcoin.org/en/how-it-works)   
[Developer](https://bitcoin.org/en/developer-documentation)

### Package-specific issue
If this package isn't up-to-date for some days, [Create an issue](https://github.com/tunisiano187/Choco-packages/issues/new/choose)

Support the package maintainer and [![Patreon](https://cdn.jsdelivr.net/gh/tunisiano187/choco-packages@f986b7f5de3afc021180256752805698d4efbc38/icons/patreon.png)](https://www.patreon.com/tunisiano)
