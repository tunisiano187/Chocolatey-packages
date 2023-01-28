$packageName        = $env:ChocolateyPackageName
$installerType      = 'exe'
$silentArgs         = '/S /D=C:\Program Files\Git'
$url32              = 'https://downloads.kitenet.net/git-annex/windows/current/git-annex-installer.exe'
$checksum32         = '1990e796cae159bfc30124e5b5ac275ad2df98287e0a7f1fd9872141fa6b6e31'
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
