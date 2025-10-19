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
	$url32 = (((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match 'DirectDownload'} | Where-Object {$_ -match "Download for Windows"} ).href)[0]
	$ReleasesNotes = (((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match 'Release notes'} ).href)
	$url32 = Get-RedirectedUrl $url32

	$version=($url32.Replace('%20', "-").split('-') | Where-Object {$_ -match "[0-9]"}).Replace('\.0$','')

	$Latest = @{ URL32 = $url32; Version = $version; ReleaseNotes = $ReleasesNotes }
	return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion