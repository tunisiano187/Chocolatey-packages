$packageName = 'emeditor'
$version = '15.0.2'
$fileType = 'exe'
$installArgs = '/exenoui /q'
$url = 'http://files.emeditor.com/emed32_15.0.2.exe'
$url64 = 'http://files.emeditor.com/emed64_15.0.2.exe'

Install-ChocolateyPackage $packageName $fileType $installArgs $url $url64