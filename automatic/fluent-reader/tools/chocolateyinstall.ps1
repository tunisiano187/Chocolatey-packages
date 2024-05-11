$ErrorActionPreference = 'Stop' # stop on all errors

$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url          = '{{DownloadUrl}}' # download url, HTTPS preferred
$checksum     = ''
$url64        = '{{DownloadUrlx64}}' # 64bit URL here (HTTPS preferred) or remove - if installer contains both (very rare), use $url
$checksum64   = ''
$checksumType = ''

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' #only one of these: exe, msi, msu
  url           = $url
  url64bit      = $url64

  softwareName  = 'fluent-reader*' #part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique

  checksum      = $checksum32
  checksumType  = $checksumType #default is md5, can also be sha1, sha256 or sha512
  checksum64    = $checksum64
  checksumType64= $checksumType #default is checksumType

  # MSI
  # silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`"" # ALLUSERS=1 DISABLEDESKTOPSHORTCUT=1 ADDDESKTOPICON=0 ADDSTARTMENU=0
  validExitCodes= @(0, 3010, 1641)
  # OTHERS
  # Uncomment matching EXE type (sorted by most to least common)
  silentArgs   = '/S'           # NSIS
  #silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
  #silentArgs   = '/s'           # InstallShield
  #silentArgs   = '/s /v"/qn"'   # InstallShield with MSI
  #silentArgs   = '/s'           # Wise InstallMaster
  #silentArgs   = '-s'           # Squirrel
  #silentArgs   = '-q'           # Install4j
  #silentArgs   = '-s'           # Ghost
  # Note that some installers, in addition to the silentArgs above, may also need assistance of AHK to achieve silence.
  #silentArgs   = ''             # none; make silent with input macro script like AutoHotKey (AHK)
                                 #       https://community.chocolatey.org/packages/autohotkey.portable
  #validExitCodes= @(0) #please insert other valid exit codes here
}

Install-ChocolateyPackage @packageArgs