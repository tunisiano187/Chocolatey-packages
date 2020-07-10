$url            = 'https://www.wagnardsoft.com/DDU/download/DDU%20V18.0.2.6.exe'
$checksum       = '4ed5dcc5f32385c3245982b9cde98e1d42651c1e6e7d1f566dc13f5212ab7fb4'
$checksumType   = 'sha256'
$referer        = 'https://www.wagnardsoft.com/forums/viewtopic.php?f=5&t=3183'

Invoke-WebRequest -Uri $referer -OutFile "$env:TEMP/test.html" #  Required to be allowed just after

$packageArgs		        = @{
    UnzipLocation	          = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
	packageName		          = $env:ChocolateyPackageName
	url				          = $url
	checksum		          = $checksum
	fileType                  = 'exe'
	checksumType              = $checksumType
	silentArgs                = '/s'
}

Install-ChocolateyZipPackage @packageArgs