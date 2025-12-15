$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'https://www.teamspeak.com/en/downloads/#server'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url32\s*=\s*)('.*')"      	= "`$1'$($Latest.URL32)'"
			"(^[$]checksum32\s*=\s*)('.*')" 	= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
			"(^[$]url64\s*=\s*)('.*')"      	= "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" 	= "`$1'$($Latest.Checksum64)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	. ..\..\scripts\Invoke-VirusTotalScan.ps1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$page = Invoke-WebRequest -Uri $releases -UseBasicParsing
	$urls = ($page.Links | Where-Object {$_ -match ".zip"} | Where-Object {$_ -match "win"}).href
	$url32 = $urls | Where-Object {$_ -match "win32"}
	$url64 = $urls | Where-Object {$_ -match "win64"}
	$version = $url32.Split('/')[-2]
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion32 = Get-FileVersion $url32
	$FileVersion64 = Get-FileVersion $url64

	$Latest = @{ URL32 = $url32; URL64 = $url64; Checksum32 = $FileVersion32.Checksum; ChecksumType32 = $FileVersion32.ChecksumType; Checksum64 = $FileVersion64.Checksum; ChecksumType64 = $FileVersion64.ChecksumType; Version = $version }
	return $Latest
}

update -ChecksumFor none
