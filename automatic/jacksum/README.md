[![](https://img.shields.io/chocolatey/v/jacksum?color=green&label=jacksum)](https://chocolatey.org/packages/jacksum) [![](https://img.shields.io/chocolatey/dt/jacksum)](https://chocolatey.org/packages/jacksum)

## Jacksum

### Cross Platform
Jacksum works on Microsoft Windows, macOS, and GNU/Linux. It even works on Android. Since Jacksum is written in Java 
you don't need to recompile it. It works out of the box the platform independent way.


### Use Cases
Jacksum covers many types of use cases in which hash values make sense:

Calculating of hash values/fingerprints of almost any input
(command line args, console, standard input, plain or encoded strings, files, partitions, disks, NTFS ADS, pipes, 
sockets, doors, ...)
Finding OK/failed/missing/new files (verify file/data integrity)
Finding files by their fingerprints for positive matching
Finding files that do not match certain fingerprints for negative matching
Finding all duplicates of a file by its hash value
Finding the algorithm(s) that generated a certain hash value
Investigate polynomials of CRCs
Investigate parameters of HMACs

### Audience
Jacksum is for users with security in mind, advanced users, sysadmins, students of informatics, computer scientists, 
cybersecurity engineers, forensics engineers, penetration testers, white hat hackers, reverse engineers, CRC researchers, 
etc. Jacksum is for professionals, but since HashGarten uses Jacksum as a program library, Jacksum is also available for 
users whose preferred user interface is a graphical interface and not the terminal.


### Algorithm Support
Jacksum supports 489 hash functions, both cryptographic and non-cryptographic hash function sets, including CRCs and classic checksums:

Adler-32, ascon-hash, ascon-hasha, ascon-xof, ascon-xofa, AST strsum PRNG hash, BLAKE-[224,256,348,512], BLAKE2b-[8..512], 

BLAKE2s-[8..256], BLAKE2bp, BLAKE2sp, BLAKE3, cksum (Minix), cksum (Unix), CRC-8 (FLAC), CRC-16 (LHA/ARC), CRC-16 (Minix), 
FCS-16, CRC-24 (OpenPGP), CRC-32 (FCS-32), CRC-32 (MPEG-2), CRC-32 (bzip2), CRC-32 (FDDI), CRC-32 (UBICRC32), CRC-32 (PHP's 
crc32), CRC-64 (ISO 3309), CRC-64 (ECMA-182), CRC-64 (prog lang GO, const ISO), CRC-64 (.xz and prog lang GO, const ECMA), 
CRC-82/DARC, DHA-256, ECHO-[224,256,348,512], ed2k, ELF (Unix), esch256, esch384, Fletcher's Checksum, FNV-0_[32,64,128,256,512,1024], 
FNV-1_[32,64,128,256,512,1024], FNV-1a_[32,64,128,256,512,1024], FORK-256, Fugue-[224,256,348,512], GOST Crypto-Pro (GOST R 34.11-94), 
GOST R 34.11-94, Groestl-[224,256,384,512], HAS-160 (KISA), HAVAL-128-[3,4,5], HAVAL-[160,192,224,256]-[3,4,5], 
JH[224,256,284,512], joaat, KangarooTwelve, Keccak[224,256,384,512], Kupyna[256,384,512] (DSTU 7564:2014), 
LSH-256-[224,256], LSH-512-[224,256,384,512] (KS X 3262), Luffa-[224,256,348,512], MD2, MD4, MD5, MDC2, MarsupilamiFourteen, 
PANAMA, PRNG hash, RIPEMD-128, RIPEMD[160,256,320], RadioGatun[32,64], SHA-0, SHA-1, SHA-[224,256,384,512], 
SHA-512/[224,256] (NIST FIPS 180-4), SHA3-[224,256,384,512], SHAKE[128,256] (NIST FIPS 202), SM3, Skein-1024-[8..1024], 
Skein-256-[8..256], Skein-512-[8..512], Streebog-[256,512] (GOST R 34.11-2012), sum (BSD Unix), sum (Minix), 
sum (System V Unix), sum [8,16,24,32,40,48,56,64], Tiger, Tiger/128, Tiger/160, Tiger2, photon-beetle, PHP Tiger 
variants (tiger192,4, tiger160,4, and tiger128,4), VSH-1024, Whirpool-0, Whirlpool-T, Whirlpool, Xoodyak, xor8, and XXH32.

Jacksum supports HMAC, a mechanism for message authentication using any iterated cryptographic hash function in 
combination with a secret shared key.

Jacksum supports the "Rocksoft (tm) Model CRC Algorithm" to describe CRCs, so additional 1.0399*10^267 customized 
CRCs can be used.


### User Interfaces
Jacksum provides a command line interface (CLI), and an application programming interface (API). A graphical user 
interface (GUI) is provided by HashGarten which is a subproject of the Jacksum project. Also, there are file browser 
integrations (FBI) available to integrate Jacksum and HashGarten into your preferred file browser such as Finder on 
macOS, Windows Explorer on Microsoft Windows or Caja, Dolphin, elementary Files, Konqueror, Krusader, Nemo, GNOME 
Nautilus, ROX-Filter, SpaceFM, Thunar, Xfe, or zzzFM on GNU/Linux.


### More features
Jacksum can recursively compute hashes with multiple algorithms simultaneously. Jacksum takes advantage of modern 
multi-processor/multi-core environments, and saves time by hashing multiple files in parallel.

Jacksum can perform a verification of hashes against a set of known hashes, and it can detect matching, non-matching, 
missing, and new files.

Output can occur in predefined standard formats (BSD-, GNU/Linux-, or Solaris style, SFV or FCIV) or in a user-defined 
format which is highly customizable, including many encodings for representing hash values, including binary, decimal, 
octal, hexadecimal with lowercase or uppercase letters, Base16, Base32 with and without padding, Base32hex with and 
without padding, Base64 with and without padding, Base64url with and without padding, BubbleBabble, and z-base-32.

Input data can come from files, standard input stream (stdin), or provided directly by command line arguments.

Jacksum supports many charsets for reading and writing files properly, and it comes with full support for all common 
Unicode aware charsets such as UTF-8, UTF-16, UTF-16BE, UTF-16LE, UTF-32, UTF-32BE, UTF-32LE, GB18030, etc.

With Jacksum you can also find the algorithm used to calculate a checksum, CRC, hash or find files that match a given 
hash value.

Jacksum provides many interfaces actually. Jacksum is a command line tool, and it can be integrated in your file browser. 
Jacksum can also be used as a runtime library in your own projects by using its API. Jacksum keeps the binary small, 
because it bundles only what it really needs to do the job.

Jacksum has opened it's source code and it is released under the terms of the GNU GPL 3 or later. Jacksum is OSI Certified 
Open Source Software. OSI Certified is a certification mark of the Open Source Initiative.  Jacksum is Free Software 
according the strong conditions of the Free Software Foundation.

Jacksum  is a synthetic word made of JAva and ChecKSUM, because Jacksum is written entirely in the Java programming language. 
Therefore the software runs cross platform, e. g. on any platform having a Java Runtime Environment including GNU/Linux, 
Microsoft Windows and macOS. without recompilation.


### Package-specific issue
If this package isn't up-to-date for some days, [Create an issue](https://github.com/tunisiano187/Chocolatey-packages/issues/new/choose)

Support the package maintainer and [![Patreon](https://cdn.jsdelivr.net/gh/tunisiano187/Chocolatey-packages@d15c4e19c709e7148588d4523ffc6dd3cd3c7e5e/icons/patreon.png)](https://www.patreon.com/tunisiano)
