$url            = 'https://www.wagnardsoft.com/DDU/download/DDU%20V18.0.2.6.exe'
$checksum       = ''
$checksumType   = ''
$referer        = 'https://www.wagnardsoft.com/forums/viewtopic.php?f=5&t=3183'

$packageArgs		        = @{
    UnzipLocation	          = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
	packageName		          = $env:ChocolateyPackageName
	url				          = $url
	checksum		          = $checksum
	fileType                  = 'exe'
	checksumType              = $checksumType
	silentArgs                = '/s'
    Options                   = @{
        Headers                 = @{
            'Accept-Encoding' = 'gzip, deflate, br'
            'Accept-Language' = 'en-US,en;q=0.9'
            'Cookie'          = 'has_js=1; cookie-agreed=2; phpbbwagnardsoft_u=1; phpbbwagnardsoft_k=; phpbbwagnardsoft_sid=dd0e2f5bcec548ecf35a899aafb05f81'
            referer           = $referer
        }
    }
}

Install-ChocolateyZipPackage @packageArgs
