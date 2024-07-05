$packageName        = $env:ChocolateyPackageName
$installerType      = 'exe'
$silentArgs         = '/S /D=C:\Program Files\Newsbin'
$url                = 'https://www.newsbin.com/download.php?reg=0&filename=nb682.exe&version=6.82'
$checksum           = 'b3c35b1231bf99bb8f344b5991d7ca6814652914f81b11553c65103cd786cec1d831566a6fb41f76607d6d9c8a43b70489cbcf16107ba6e669752036a0d25652'
$checksumType       = 'SHA512'
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
