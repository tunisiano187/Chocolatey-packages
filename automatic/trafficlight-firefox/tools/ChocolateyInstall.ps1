$packageName  = 'trafficlight-firefox'
$url          = 'https://addons.mozilla.org/firefox/downloads/file/4676912/trafficlight-3.4.1.xpi'
$checksum     = 'AE304462A4810EB3F8CC925A5220F563F806E7BFF1F36193DFEBE66A8E5B8931'
$checksumType = 'sha256'
$extensionID  = "{6c4e0842-d473-48fd-a930-67dbcea33345}"

if(test-path 'hklm:\SOFTWARE\Mozilla\Firefox\TaskBarIDs'){
	$installDir = Get-Item -Path Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Mozilla\Firefox\TaskBarIDs | Select-Object -ExpandProperty Property
}
if(test-path 'hklm:\SOFTWARE\Wow6432Node\Mozilla\Firefox\TaskBarIDs'){
  $installDir = Get-Item -Path Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Mozilla\Firefox\TaskBarIDs | Select-Object -ExpandProperty Property
}

$browserFolder = Join-Path $installDir "browser"
$extensionsFolder = Join-Path $browserFolder "extensions"
$extFolder = Join-Path $extensionsFolder "$extensionID"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $extFolder
  fileType      = 'ZIP'
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

if (!(Test-Path $extFolder)) {
	New-Item -Force -ItemType directory -Path $extFolder
	Install-ChocolateyZipPackage @packageArgs
}
else {
  Write-Host "$packageName already exists"
}
