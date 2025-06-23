$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://mblock.cc/pages/downloads'

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

	$Latest = @{ URL32 = $url32; Version = $version; Referer = $releases }
	return $Latest
}

try {
	update -ChecksumFor 32 -NoCheckChocoVersion -NoCheckUrl
} catch {
	$ignore = "Job returned no object, Vector smash ?"
	if ($_ -match $ignore) { Write-Output $ignore; 'ignore' } else { throw $_ }
}