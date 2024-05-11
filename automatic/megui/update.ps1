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
	$url32 = ((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match '.7z'}).href | Select-Object -First 1
	$ver = $url32.Split('/')[-2]
	if($ver -match "&") {
		$ver = $ver -split '&' | Select-Object -First 1
	}
	$version = "1.0.$($ver)"
	$url32 = "https://master.dl.sourceforge.net/project/megui/megui-stable/$ver/MeGUI-$ver-32.7z"

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32
