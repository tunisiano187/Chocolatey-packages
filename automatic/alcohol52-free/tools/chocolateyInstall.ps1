$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$filePath32 = "$toolsPath\alcohol52-free.installer.exe"

$packageArgs = @{
	packageName            = 'alcohol52-free'
	fileType               = 'exe'
	url                    = 'http://www.filefacts.com/alcohol-52-free-edition-quickdownload'
	checksum               = 'A923B80BAA0D650F47D196ACD25C7CF7780BB2AA8E9174720E1FBE7523546C69'
	checksumType           = 'sha256'
	silentArgs             = '/S'
	validExitCodes         = @(0)
	softwareName           = 'Alcohol 52% Free Edition'
}

# Spoof user agent to download installer in stead of downloader
$userAgent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.246'

Get-WebFile "$($packageArgs.url)" "$filePath32" "$userAgent"

Start-ChocolateyProcessAsAdmin "$($packageArgs.silentArgs)" "$filePath32"
