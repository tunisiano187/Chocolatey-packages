$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

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
	$version = $tags.tag_name.Replace('v','')
	if($url32.Count -eq 0) {
		$url32 = "https://codeberg.org/ltguillaume/redshift-tray/releases/download/2.3.0/redshift-tray_2.3.0.zip"
		$url32 = $url32 -replace "2.3.0",$version
	}
	if($tags.prerelease -match "true") {
		$date = $tags.published_at.ToString("yyyyMMdd")
		$version = "$version-pre$($date)"
	}
	Invoke-WebRequest -Uri $url32 -OutFile ".\tools\redshift-tray.zip"
	Update-Metadata -key "releaseNotes" -value $tags.html_url
	Invoke-WebRequest -Uri "https://raw.githubusercontent.com/ltGuillaume/Redshift-Tray/master/LICENSE" -OutFile "$(Get-Location)\tools\license.txt"

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -Debug
