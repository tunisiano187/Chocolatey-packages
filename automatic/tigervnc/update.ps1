$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://sourceforge.net/projects/tigervnc/files/stable'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url32\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum32\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 		= "`$1'$($Latest.ChecksumType32)'"
			"(^[$]url64\s*=\s*)('.*')"      		= "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum64)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$version = ((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_.href -match "[0-9].[0-9]"} | Where-Object {$_.href -notmatch 'css'}).href[0].split('/')[-2]
	$url32 = "$releases/$version/tigervnc-$version.exe/download"
	$url64 = "$releases/$version/tigervnc64-$version.exe/download"

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

update