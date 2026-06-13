$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

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
	. ..\..\scripts\Invoke-VirusTotalScan.ps1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$releases = 'https://www.ost2.com/en/thankyou'
	$headers  = @{ 'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36' }
	$page = Invoke-WebRequest -Uri $releases -UseBasicParsing -Headers $headers
	$regexPattern = 'Version:\s*(\d+(\.\d+)*)'
	$versionMatch = $page.Content | Select-String -Pattern $regexPattern -AllMatches
	if (-not $versionMatch -or -not $versionMatch.Matches.Count) {
		throw "Version not found on $releases - page layout may have changed"
	}
	$version = $versionMatch.Matches[0].Groups[1].Value
	$url32 = "https://d.4team.biz/files/ost2_setup.exe"

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -NoCheckUrl -NoCheckChocoVersion -ChecksumFor none
