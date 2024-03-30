$packageName = 'install4j.install'
$installerType = 'exe'
$silentArgs = '-q'
$url = 'https://download-gcdn.ej-technologies.com/install4j/install4j_windows_7_0_11.exe'
$checksum = '6e7dde41388f5ad87fe764972d30f07945e7dd47736d3867b8856a29bd7e87e6'
$checksumType = 'sha256'
$url64 = 'https://download-gcdn.ej-technologies.com/install4j/install4j_windows-x64_7_0_11.exe'
$checksum64 = '84db72f7484d5c3ccfadae31a08d102785021bfecce79bab9202aa0229e870c1'
$checksumType64 = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -Url64bit "$url64" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType" `
                          -Checksum64 "$checksum64" `
                          -ChecksumType64 "$checksumType64"