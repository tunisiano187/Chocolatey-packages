$packageName        = $env:ChocolateyPackageName
$installerType      = 'exe'
$silentArgs         = '/S /D=C:\Program Files\Git'
$url32              = 'https://downloads.kitenet.net/git-annex/windows/current/git-annex-installer.exe'
$checksum32         = 'b7c07f1b5cc7cc07ebdd24526a6918812a3bcf84538ec29cf55598b21ae2f5c8'
$checksumType32     = 'sha256'
$validExitCodes     = @(0)

$scriptPath     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkFile        = Join-Path $scriptPath "chocolateyInstall.ahk"
$ahkExe         = 'AutoHotKey'
$ahkRun         = "$Env:Temp\$(Get-Random).ahk"

Copy-Item $ahkFile "$ahkRun" -Force
Start-Process $ahkExe $ahkRun

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url32" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum32" `
                          -ChecksumType "$checksumType32"
