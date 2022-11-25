import-module au

$releases = 'https://sourceforge.net/projects/megui/files/latest/download'

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
	$url32 = ((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match '.zip'}).href | Select-Object -First 1
	$ver = $url32.Split('-')[-2]
	$version = "1.0.$($url32.Split('-')[-2])"
	$url32 = "https://jztkft.dl.sourceforge.net/project/megui/megui-stable/$ver/MeGUI-$ver-32.zip"

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32
