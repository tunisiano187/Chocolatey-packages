$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://api.github.com/repos/dsccommunity/xHyper-V/releases/latest'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_GetLatest {
	$tags = Invoke-WebRequest $releases -UseBasicParsing | ConvertFrom-Json
	$url32 = $tags[0].zipball_url
	$version = $url32.split('v')[-1]
	Write-Output "Version : $version"

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32
