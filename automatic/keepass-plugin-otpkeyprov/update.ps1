$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'https://keepass.info/plugins.html'

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
	$links = (Invoke-WebRequest -Uri $releases -UseBasicParsing).Links |
		Where-Object { $_.href -match "OtpKeyProv-" } |
		Where-Object { $_.href -notmatch '-source' }
	if (-not $links) { throw "Could not find OtpKeyProv download link on keepass.info/plugins.html" }
	$href = ($links | Select-Object -First 1).href
	$url32 = "https://keepass.info/$href"
	$version = $url32.split('-')[-1].Replace('.zip', '')

	return @{ URL32 = $url32; Version = $version }
}

update -ChecksumFor 32 -NoCheckChocoVersion
