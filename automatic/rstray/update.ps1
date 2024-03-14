$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://api.github.com/repos/ltGuillaume/Redshift-Tray/releases/latest'
$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 2

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]version\s*=\s*)('.*')"      	= "`$1'$($Latest.VERSION)'"
		}
		"tools\VERIFICATION.txt"      = @{
			"(?i)(x86:).*"        				= "`${1} $($Latest.URL32)"
			"(?i)(checksum:).*" 				= "`${1} $($Latest.Checksum32)"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo -Latest
	$url32 = $tags.assets.browser_download_url | Where-Object {$_ -match ".zip$"}
	Invoke-WebRequest -Uri $url32 -OutFile ".\tools\redshift-tray.zip"
	Update-Metadata -key "releaseNotes" -value $tags.html_url
	$version = $tags.tag_name.Replace('v','')
	if($tags.prerelease -match "true") {
		$date = $tags.published_at.ToString("yyyyMMdd")
		$version = "$version-pre$($date)"
	}
	Invoke-WebRequest -Uri "https://raw.githubusercontent.com/ltGuillaume/Redshift-Tray/master/LICENSE" -OutFile "$(Get-Location)\tools\license.txt"

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -Debug