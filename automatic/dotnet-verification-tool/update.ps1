$ErrorActionPreference = 'Stop'
import-module au

$release = 'https://learn.microsoft.com/fr-fr/archive/blogs/astebner/net-framework-setup-verification-tool-users-guide'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url(32)?\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum(32)?\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType(32)?\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$page = Invoke-WebRequest -Uri $release -UseBasicParsing
	$url32 = $page.Links.href | Where-Object {$_ -match "verifier_new.zip$"} | Select-Object -First 1
	. ..\..\scripts\Get-FileVersion.ps1
	$FileInfo = Get-FileVersion $url32

	$Latest = @{ URL32 = $url32; Version = $FileInfo.Version; Checksum32 = $FileInfo.CHECKSUM; ChecksumType32 = $FileInfo.ChecksumType }
	return $Latest
}

update -ChecksumFor none