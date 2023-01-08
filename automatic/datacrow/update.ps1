import-module au

$releases = 'https://sourceforge.net/projects/datacrow/files/latest/download'

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
	$url32 = "https://sourceforge.net$(((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match '.zip'}).href | Select-Object -First 1)"
	$version = $url32.Split('_') | Where-Object {$_ -match "[0-9]\."}
	$url32 = $releases
	#$url32 = "https://netcologne.dl.sourceforge.net/project/datacrow/files/datacrow_$($version)_windows_installer.zip"

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32
