$packageName = 'belarc-advisor'
$fileType = 'exe'
$url = 'http://www.belarc.com/Programs/advisorinstaller.exe'
$silentArgs = '/S'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url


