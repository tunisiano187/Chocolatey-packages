$packageName = 'RAD'
$fileType = 'exe'
$url = 'D:\Soft\rad.exe'

$silentArgs = '/SILENT'
$validExitCodes = @(0)


Install-ChocolateyPackage "packageName" "$fileType" "$silentArgs" "$url"  -validExitCodes  $validExitCodes  -checksum "@{Algorithm=SHA256; Hash=1C7B56087BD4D0170D31C845BE2CC31A868C3E13D94C1D0B3412979AD66B5419; Path=D:\Soft\rad.exe}" -checksumType "sha256"
