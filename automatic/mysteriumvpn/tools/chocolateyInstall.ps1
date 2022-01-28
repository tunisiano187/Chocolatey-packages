$packageName    = $env:ChocolateyPackageName
$url            = 'https://github.com/iBotPeaches/Apktool/releases/download/v2.6.0/apktool_2.6.0.jar'
$checksum       = 'f750a3cd2c1f942f27f5f7fd5d17eada3bdaff0a6643f49db847e842579fdda5'
$checksumType   = 'sha256'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
    packageName   = $packageName
    unzipLocation = $toolsDir
    fileType      = 'EXE'
    url           = $url
  
    softwareName  = 'mysterium*'
  
    checksum      = $checksum
    checksumType  = $checksumType
  
    silentArgs   = '/S' # NSIS
    validExitCodes= @(0)
  }
  
  Install-ChocolateyPackage @packageArgs