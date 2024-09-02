import-module au

$url32 = 'https://frinklang.org/frinkjar/frink.jar'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$url = "https://frinklang.org/whatsnew.html"
	$page = Invoke-WebRequest -Uri $url -UseBasicParsing

	$regex = "\d{4}-\d{2}-\d{2}"

	$dates = [regex]::Matches($page.Content, $regex) | ForEach-Object { $_.Value }
	$recentDate = $dates | Select-Object -First 1
	$version = $recentDate.Replace("-",".")

	  . ..\..\scripts\Get-FileVersion.ps1
	  $FileVersion = Get-FileVersion $url32

	$Latest = @{ URL32 = $url32; Version = $version; Checksum32 = $FileVersion.Checksum; ChecksumType32 = $FileVersion.ChecksumType32 }
	return $Latest
}

update -ChecksumFor none