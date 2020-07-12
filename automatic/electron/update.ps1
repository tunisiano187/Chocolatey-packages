import-module au

$releases = 'https://github.com/electron/electron/releases/latest/'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
			"(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
			"(^[$]checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
		}
	}
}

function global:au_GetLatest {
	Write-Output 'Check Folder'
	$url32 = $((((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links)) | Where-Object {$_ -match 'electron-'} | Where-Object {$_ -match 'win32-ia32.zip'}).href
	$url64 = $((((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links)) | Where-Object {$_ -match 'electron-'} | Where-Object {$_ -match 'win32-x64.zip'}).href
	Write-Output 'Checking version'
	#$version=$url64.split('/')[5].replace('v','')
	$version = Get-Version $url64
	Write-Output "Version : $version"
	$url32 = "https://github.com$($url32)";
	$url64 = "https://github.com$($url64)";

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

update -NoCheckChocoVersion