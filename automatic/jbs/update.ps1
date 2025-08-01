$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

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
	$version = Get-Version (($jbs.Links | Where-Object {$_ -match '\.zip'})[0].href)

	$Latest = @{ URL32 = $url32; Version = Get-FixVersion $version -OnlyFixBelowVersion $padVersionUnder }
	return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion
