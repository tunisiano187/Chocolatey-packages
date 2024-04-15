$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://www.mblock.cc/en/download/'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
			"(^[$]referer\s*=\s*)('.*')" = "`$1'$($Latest.Referer)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$page = Invoke-WebRequest -Uri $releases
	$regexPattern = 'Version: V(\d+(\.\d+)*)'
	$versionMatch = $page.Content | Select-String -Pattern $regexPattern -AllMatches
	$version = $versionMatch.Matches[0].Groups[1].Value
	$url32 = "https://dl.makeblock.com/mblock5/win32/V$version.exe"
	
	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion -NoCheckUrl