$ErrorActionPreference = 'Stop';

$packageName = 'amazingmarvin'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'http://amazingmarvin.s3-website-us-east-1.amazonaws.com/MarvinSetup.exe'

$packageArgs = @{
    packageName    = $packageName
    unzipLocation  = $toolsDir
    fileType       = 'EXE'
    url            = $url
    softwareName   = 'amazingmarvin*'
    checksum       = 'D59733BABCE5786D6F49DA57BD05CBD00E9448E003B4744F20807043B3819FB3'
    checksumType   = 'sha256'
    silentArgs     = '/S'
    validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs