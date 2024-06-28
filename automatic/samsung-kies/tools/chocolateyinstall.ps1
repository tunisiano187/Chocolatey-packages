$packageName= 'samsung-kies'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://downloadcenter.samsung.com/content/SW/201604/20160428144359623/Kies3Setup.exe' 

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url
  checksum      = '4B5628AA53824993E039538518DCCBDA2D6A81DD0C0EA2740DFDF96C1953B037'
  checksumType  = 'sha256'   
  silentArgs   = '/S /v/qn'  
  validExitCodes= @(0) 
  softwareName  = 'Samsung Kies3*'
}

Install-ChocolateyPackage @packageArgs
