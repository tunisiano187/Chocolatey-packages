import-module au

$releases = 'https://sourceforge.net/projects/freeplane/files/freeplane%20stable/'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$url32 = ((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match '-setup-'} | Where-Object {$_ -match '.exe'} | Where-Object {$_ -match "https"}).href | Select-Object -First 1
	#$version = $url32.split('-')[-1].split("x")[0].replace('.e','')
	$version = Get-Version $url32

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32
