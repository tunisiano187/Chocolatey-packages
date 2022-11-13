$packageName = 'git-annex'
$installerType = 'exe'
$silentArgs = '/S /D=C:\Program Files\Git'
$url = 'https://downloads.kitenet.net/git-annex/windows/current/git-annex-installer.exe'
$checksum = 'b9b479d4f137c79563ed27b61577c9a5794aa2fc83d9bf700a4d0f6816c98be2'
$checksumType = 'sha256'
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
                          -ChecksumType "$checksumType"