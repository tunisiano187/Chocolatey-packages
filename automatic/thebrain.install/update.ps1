$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'https://thebrain.com/download'

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
	Update-Metadata -key "releaseNotes" -value $Latest.ReleaseNotes
	. ..\..\scripts\Invoke-VirusTotalScan.ps1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$response = Invoke-WebRequest -Uri $releases -UseBasicParsing
	$downloadLink = $response.Links | Where-Object {$_.href -match 'DirectDownload'} | Where-Object {$_.href -match 'Download for Windows'} | Select-Object -First 1
	if (-not $downloadLink) {
		throw "Could not find DirectDownload link for Windows"
	}
	$url32 = $downloadLink.href
	$ReleaseNotesLink = $response.Links | Where-Object {$_.href -match 'Release notes'} | Select-Object -First 1
	$ReleasesNotes = $ReleaseNotesLink.href
	$url32 = Get-RedirectedUrl $url32

	$version = ($url32.Replace('%20', "-").split('-') | Where-Object {$_ -match "[0-9]"} | Select-Object -First 1).Replace('\.0$','')

	$Latest = @{ URL32 = $url32; Version = $version; ReleaseNotes = $ReleasesNotes }
	return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion