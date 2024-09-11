$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
#$url           = ''
$url64          = 'https://proton.me/download/PassDesktop/win32/x64/ProtonPass_Setup_1.22.3.exe'
$checksum64     = 'd7a876b53c72c787fae9de0b51fdb791a3e3a4a6e9daad60424c4bb76be584f0'
$checksumType64 = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  #url           = $url
  url64bit      = $url64
  silentArgs    = "/s"
  validExitCodes= @(0)
  softwareName  = 'Proton Pass*' #part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique
  #checksum      = '{{Checksum}}'
  #checksumType  = '{{ChecksumType}}' #default is md5, can also be sha1, sha256 or sha512
  checksum64    = $checksum64
  checksumType64= $checksumType64
}

Install-ChocolateyPackage @packageArgs # https://docs.chocolatey.org/en-us/create/functions/install-chocolateypackage
