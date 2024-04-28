$ErrorActionPreference = 'Stop'
 
$packageArgs = @{
  packageName            = 'AccessDirector'
  fileType               = 'MSI'
  url                    = 'http://nolightpeople.com/~/file.axd?file=/downloads/Access_Director_250.msi'
  checksum               = '7F7AE0831F222932230A52E2AB4ABD16D5DDEE0754F2EDCC61A8B3111EA335B9'
  checksumType           = 'sha256'
  silentArgs             = '/qn'
  validExitCodes         = @(0)
  softwareName           = 'Access Director *'
}
Install-ChocolateyPackage @packageArgs