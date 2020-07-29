import-module au

$releases = 'https://github.com/lbryio/lbry-desktop/releases'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_GetLatest {
	Write-Output 'Check Folder'
	$url32 = $((((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links)) | Where-Object {$_ -match 'LBRY-'} | Where-Object {$_ -match '.exe'}).href
	Write-Output 'Checking version'
	#$version=$url64.split('/')[5].replace('v','')
	$version = Get-Version $url64
	Write-Output "Version : $version"
	$url32 = "https://github.com$($url32)";

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32