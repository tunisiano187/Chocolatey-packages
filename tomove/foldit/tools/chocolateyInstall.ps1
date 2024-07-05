$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$installerType = 'exe'
$url = 'https://files.ipd.uw.edu/pub/foldit/Foldit-win_x64.exe'
$checksum = '88bd348dae7513c70add5f1cd0b16b5337edb3fd58e97447852206aba333543d'
$checksumType = 'sha256'
$validExitCodes = @(0)
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installPath = Join-Path $toolsDir "Foldit"
$silentArgsBase = '/S /D='
$silentArgs = $($silentArgsBase + '"' + $installPath + '"')

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType"
