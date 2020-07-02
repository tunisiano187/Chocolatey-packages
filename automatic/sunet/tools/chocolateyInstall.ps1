$packageName = $env:ChocolateyPackageName
$installerType = 'exe'
$silentArgs = '/S /v/qn'
$url = 'https://boinc-client.oss-accelerate.aliyuncs.com/SUNET%20Setup.exe'
$checksum = 'dae8e554d1db46552ee28bf22362cb47047385c9e822d5eff096e560ca8bdb5b'
$checksumType = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType"
