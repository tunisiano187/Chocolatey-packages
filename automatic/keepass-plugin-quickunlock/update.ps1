$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://api.github.com/repos/JanisEst/KeePassQuickUnlock/releases/latest'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_GetLatest {
	$tags = Invoke-WebRequest $releases -UseBasicParsing | ConvertFrom-Json
	$url32 = ($tags[0].assets | Where-Object {$_.browser_download_url -match ".plgx$"}).browser_download_url

	Write-Verbose 'Checking version'
	$version=($tags[0].name.Split(' ')[1]).replace('v','')

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32
