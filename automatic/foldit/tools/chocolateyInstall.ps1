$packageName = 'foldit'
$installerType = 'exe'
$url = '{{DownloadUrl}}'
$checksum = '{{Checksum}}'
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