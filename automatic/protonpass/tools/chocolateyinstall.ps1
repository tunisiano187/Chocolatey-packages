$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
#$url        = ''
$url64      = 'https://proton.me/download/PassDesktop/win32/x64/ProtonPass_Setup_1.16.7.exe'

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
  checksum64    = '6ED86BF91D59F16D0F4F02CF8961CBCA461264160CB3F5CD326EDF71297CC948'
  checksumType64= 'sha256' #default is checksumType
}

Install-ChocolateyPackage @packageArgs # https://docs.chocolatey.org/en-us/create/functions/install-chocolateypackage