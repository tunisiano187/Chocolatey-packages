$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://johnsad.ventures/software/backgroundswitcher/windows/'
$padVersionUnder = '5.4.0.3'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$jbs = (Invoke-WebRequest -Uri $releases -UseBasicParsing)
	$url32 = ($jbs.Links | Where-Object {$_ -match '\.exe'})[0].href
	$page = Invoke-WebRequest -Uri $releases -UseBasicParsing
	$regexPattern = 'Version (\d+(\.\d+)*)'
	$versionMatch = $page.Content | Select-String -Pattern $regexPattern -AllMatches
	$version = $versionMatch.Matches[0].Groups[1].Value

	$Latest = @{ URL32 = $url32; Version = Get-FixVersion $version -OnlyFixBelowVersion $padVersionUnder }
	return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion
