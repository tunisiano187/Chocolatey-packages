$ErrorActionPreference = 'Stop'
import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$releases = 'https://github.com/openhab/openhab-distro/releases/latest'
$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 2
function global:au_SearchReplace {
	@{
		"tools\chocolateyinstall.ps1" = @{
			"(?i)(url\s*=\s*')[^']*"          = "`${1}$($Latest.URL32)"
			"(?i)(checksum\s*=\s*')[^']*"     = "`${1}$($Latest.Checksum32)"
			"(?i)(checksumType\s*=\s*')[^']*" = "`${1}$($Latest.ChecksumType32)"
		}
		"legal\VERIFICATION.txt"      = @{
			"(?i)(x86:).*"        				= "`${1} $($Latest.URL32)"
			"(?i)(checksum:).*" 				= "`${1} $($Latest.Checksum32)"
			"(?i)(checksumtype:).*" 			= "`${1} $($Latest.ChecksumType32)"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo -Latest
	# [\d.]* doesn't allow letters, so it never matched milestone-suffixed zip filenames like
	# "openhab-5.3.0.M1.zip" (confirmed live) -- $url32 silently ended up empty, and the
	# downstream Get-FileVersion call threw the opaque "Cannot bind argument to parameter
	# 'Path' because it is an empty string." Allow an optional dot-separated word suffix
	# (M1, RC1, etc.) so milestone/candidate builds resolve too.
	$url32 = ($tags.assets.browser_download_url | Where-Object {$_ -match "/openhab-\d[\d.]*(\.\w+)?\.zip$"}) | Select-Object -First 1
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $url32
	$version = $tags.tag_name.Replace('v','').Replace('.M','-M')
	Update-Metadata -key "releaseNotes" -value $tags.html_url
	Update-Metadata -key "licenseUrl" -value $((Get-GitHubLicense -OwnerName $Owner -RepositoryName $repo).download_url)
	if($tags.prerelease -match "true") {
	    $date = $tags.published_at.ToString("yyyyMMdd")
	    $version = "$version-pre$($date)"
	}


	$Latest = @{ URL32 = $url32; Checksum32 = $FileVersion.Checksum; ChecksumType32 = $FileVersion.ChecksumType; Version = $version }
	return $Latest
}

update -ChecksumFor none
