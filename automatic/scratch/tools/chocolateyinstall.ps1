$packageName = 'scratch'
$fileType = 'msi'
$url = 'https://portail.csdesiles.qc.ca/chocolatey/scratch/scratch1.4.msi'
$silentArgs = '/qn /norestart'
$validExitCodes = @(0, 3010, 1641)

Install-ChocolateyPackage "$packageName" "$fileType" "$silentArgs" "$url"  -validExitCodes  $validExitCodes  -checksum "6904F6248D5D62622F4F33094B114EFAD4FA0FE0BFE322F913C4213F2A83A3BB" -checksumType "sha256"
