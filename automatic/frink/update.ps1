import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

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

function global:au_BeforeUpdate {
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $Latest.URL32
	$Latest.Checksum32 = $FileVersion.Checksum
	$Latest.ChecksumType32 = $FileVersion.checksumType
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

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor none -NoCheckChocoVersion