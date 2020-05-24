$packageName= 'FileJuggler'
$installerType      = 'EXE'
$silentArgs = '/s'
$url        = 'https://www.filejuggler.com/download/filejuggler.exe'
$checksum   = 'C0ACFE3DCB51ABD982A4AA4CF5369AB6'

Install-ChocolateyPackage $packageName $installerType $silentArgs $url -checksum $checksum -ValidExitCodes @(0,1223)
