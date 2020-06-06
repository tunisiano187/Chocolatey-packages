function Set-DefaultBrowser
{
	$regKey      = "HKCU:\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\{0}\UserChoice"
    $regKeyFtp   = $regKey -f 'ftp'
    $regKeyHttp  = $regKey -f 'http'
    $regKeyHttps = $regKey -f 'https'

	Set-ItemProperty $regKeyFtp   -name ProgId FirefoxURL
	Set-ItemProperty $regKeyHttp  -name ProgId FirefoxURL
	Set-ItemProperty $regKeyHttps -name ProgId FirefoxURL
}

cup -y firefox
Set-DefaultBrowser
