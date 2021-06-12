import-module au

$releases = 'https://sourceforge.net/projects/windjview/files/WinDjView/2.1/'

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
	$url32 = ((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match '-setup.'} | Where-Object {$_ -match '.exe'} | Where-Object {$_ -match "https"}).href | Select-Object -First 1
	$version = Get-Version $url32
	if($version -eq '2.1') {
		$version="2.1.0.20210612"
	}

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32
