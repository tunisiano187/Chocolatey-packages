$packageName        = $env:ChocolateyPackageName
$installerType      = 'exe'
$silentArgs         = '/S /D=C:\Program Files\Newsbin'
$url                = 'http://www.newsbin.com/downloads/nb672-full.exe'
$checksum           = 'a02b43c90598585d87a1b63d6edcb4da92df5c760465b85d74006445a4aa2eb4'
$checksumType       = 'sha1'
$validExitCodes = @(0)

$scriptPath = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$ahkExe = 'AutoHotKey'
$ahkFile = Join-Path $scriptPath "chocolateyInstall.ahk"
Start-Process $ahkExe $ahkFile

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType" `
