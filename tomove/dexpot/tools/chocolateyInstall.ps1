$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$installerType = 'EXE'
$url = 'https://dexpot.de/download/dexpot_1614_r2439.exe'
$checksum = '1b87a1c31d721708a679673f098a73f77d01b9e5c5ab18709eac388746e6f46a'
$checksumtype = 'sha256'
$silentArgs = '/S'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                        -FileType "$installerType" `
                        -SilentArgs "$silentArgs" `
                        -Url "$url" `
                        -ValidExitCodes $validExitCodes `
                        -Checksum "$checksum" `
                        -ChecksumType "$checksumType" `
