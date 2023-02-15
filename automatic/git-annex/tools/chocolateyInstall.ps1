$packageName        = $env:ChocolateyPackageName
$installerType      = 'exe'
$silentArgs         = '/S /D=C:\Program Files\Git'
$url32              = 'https://downloads.kitenet.net/git-annex/windows/current/git-annex-installer.exe'
$checksum32         = '9601fb9fae6c1effb7a8df6b1a2996653ec0990f78fd482cd3861e938f0874ba'
$checksumType32     = 'sha256'
$validExitCodes     = @(0)

$scriptPath = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$ahkExe = 'AutoHotKey'
$ahkFile = Join-Path $scriptPath "chocolateyInstall.ahk"
Start-Process $ahkExe $ahkFile

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url32" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum32" `
                          -ChecksumType "$checksumType32"
