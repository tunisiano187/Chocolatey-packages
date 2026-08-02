$packageName = $env:ChocolateyPackageName
$installerType = 'exe'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$File = Get-Item $toolsPath\*.exe
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -File "$File" `
                          -ValidExitCodes $validExitCodes
