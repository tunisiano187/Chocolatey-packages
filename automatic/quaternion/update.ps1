$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://api.github.com/repos/quotient-im/Quaternion/releases/latest'
$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 2

function global:au_SearchReplace {
	@{
		"tools\VERIFICATION.txt"      = @{
			"(?i)(32-bit:).*"        				= "`${1} $($Latest.URL32)"
			"(?i)(checksum32 =).*" 				= "`${1} $($Latest.Checksum32)"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo -Latest
	$url32 = $tags.assets.browser_download_url | Where-Object {$_ -match ".zip$"}
	Invoke-WebRequest -Uri $url32 -OutFile ".\tools\quaternion_windows.zip"
	$version = $tags.tag_name.Replace('v','')
	if($tags.prerelease -match "true") {
		$date = $tags.published_at.ToString("yyyyMMdd")
		$version = "$version-pre$($date)"
	}
	Invoke-WebRequest -Uri "https://raw.githubusercontent.com/quotient-im/Quaternion/master/LICENSE.spdx" -OutFile "$(Get-Location)\legal\license.txt"

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update