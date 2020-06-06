import-module au

$release = 'https://appdownload.deepl.com/windows/full/DeepLSetup.exe'

function Set-DefaultBrowser
{
    cup -y firefox
	
	$regKey      = "HKCU:\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\{0}\UserChoice"
    $regKeyFtp   = $regKey -f 'ftp'
    $regKeyHttp  = $regKey -f 'http'
    $regKeyHttps = $regKey -f 'https'

	Set-ItemProperty $regKeyFtp   -name ProgId FirefoxURL
	Set-ItemProperty $regKeyHttp  -name ProgId FirefoxURL
	Set-ItemProperty $regKeyHttps -name ProgId FirefoxURL
} 

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
		}
	}
}

function global:au_GetLatest {
	Set-DefaultBrowser
	cinst -y deepl --ignore-checksums
	$version=$(ls "$($env:LOCALAPPDATA)\deepl\app*" -Directory).Name.split("-")[1]
	
	$Latest = @{ URL64 = $release; Version = $version }
	return $Latest
}

update -ChecksumFor 64