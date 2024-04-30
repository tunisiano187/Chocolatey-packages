$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName = 'agentsvn'
$installerType = 'exe'
$silentArgs = '/sp- /silent /norestart /suppressmsgboxes'
$url = 'http://www.zeusedit.com/agent/bin/asvn-v256.exe'

Install-ChocolateyPackage $packageName $installerType $silentArgs $url
