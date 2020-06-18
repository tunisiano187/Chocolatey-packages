import-module au

$releases = 'https://github.com/electron/electron/releases/latest/'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
		}
	}
}

function global:au_GetLatest {
	Write-host 'Check Folder'
	$url32 = $((((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links)) | Where-Object {$_ -match 'electron-'} | Where-Object {$_ -match 'win32-ia32.zip'}).href
	$url64 = $((((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links)) | Where-Object {$_ -match 'electron-'} | Where-Object {$_ -match 'win32-x64.zip'}).href
	Write-host 'Checking version'
	$version=$url64.split('/')[5].replace('v','')
	Write-host "Version : $version"
	$url32 = "https://github.com$($installer[0])";
	$url64 = "https://github.com$($installer[1])";
	
	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

update