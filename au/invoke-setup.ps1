function Set-DefaultBrowser
{
	$regKey      = "HKCU:\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\{0}\UserChoice"
    $regKeyFtp   = $regKey -f 'ftp'
    $regKeyHttp  = $regKey -f 'http'
    $regKeyHttps = $regKey -f 'https'

	Set-ItemProperty $regKeyFtp   -name ProgId ChromeHTML
	Set-ItemProperty $regKeyHttp  -name ProgId ChromeHTML
	Set-ItemProperty $regKeyHttps -name ProgId ChromeHTML
}

cup -y googlechrome
Set-DefaultBrowser
