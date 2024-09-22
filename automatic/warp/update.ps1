$ErrorActionPreference = 'Stop'
import-module au

$releases = "https://1111-releases.cloudflareclient.com/windows/Cloudflare_WARP_Release-x64.msi"

function global:au_BeforeUpdate {
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $Latest.URL64
	$Latest.Checksum64 = $FileVersion.Checksum
	$Latest.ChecksumType64 = $FileVersion.checksumType
}

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url64\s*=\s*)('.*')"      		= "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum64)'"
			"(^[$]checksumType64\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType64)'"
		}
	}
}

function global:au_GetLatest {
	$url64=$releases

	$page = Invoke-WebRequest -Uri "https://install.appcenter.ms/api/v0.1/apps/cloudflare/1.1.1.1-windows-1/distribution_groups/release/public_releases?scope=tester&top=1" -UseBasicParsing
	$regexPattern = '"version":"(\d+(\.\d+)*)'
	$versionMatch = $page.Content | Select-String -Pattern $regexPattern -AllMatches
	$version = $versionMatch.Matches[0].Groups[1].Value

	$Latest = @{ URL64 = $url64; Version = $version}

    return $Latest
}

update -ChecksumFor none
