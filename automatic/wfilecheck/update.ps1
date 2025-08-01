$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'https://sourceforge.net/projects/whirlpoolfilech/'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      			= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 			= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 		= "`$1'$($Latest.ChecksumType32)'"
			"(^[$]url64\s*=\s*)('.*')"      		= "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum64)'"
			"(^[$]checksumType64\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType64)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_BeforeUpdate($Package) {
	if(Test-Path('tools\.exe')) {
		Remove-Item 'tools\.exe'
	}
}

function global:au_GetLatest {
	$urls = (Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_.href -match '.exe$'}
	$version = $urls[0].href.split('/') | Where-Object {$_ -match "[0]."}
	$url32 = "$(($urls | Where-Object {$_.href -match "32"}).href)/download"
	$url64 = "$(($urls | Where-Object {$_.href -match "64"}).href)/download"

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

update -NoCheckChocoVersion
