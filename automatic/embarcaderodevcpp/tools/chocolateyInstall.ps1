$packageName = $env:ChocolateyPackageName
$installerType = 'exe'
$silentArgs = '/S'
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$File = Get-Item $toolsPath\*.exe
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -File "$File" `
                          -ValidExitCodes $validExitCodes
