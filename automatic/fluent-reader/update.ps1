$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'https://api.github.com/repos/yang991178/fluent-reader/releases/latest'
$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 2

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumtype\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
			"(^[$]url64\s*=\s*)('.*')"      	= "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" 	= "`$1'$($Latest.Checksum64)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo -Latest
	$urls = $tags.assets.browser_download_url | Where-Object {$_ -match ".exe$"}
	$url32 = $urls | Where-Object {$_ -match "x86"}
	$url64 = $urls | Where-Object {$_ -match "x64"}
	$version = $tags.tag_name.Replace('v','')
	Update-Metadata -key "releaseNotes" -value $tags.html_url
	. ..\..\scripts\Get-GithubRepositoryLicense.ps1
	Update-Metadata -key "licenseUrl" -value $(Get-GithubRepositoryLicense $Owner $repo)
	if($tags.prerelease -match "true") {
		$date = $tags.published_at.ToString("yyyyMMdd")
		$version = "$version-pre$($date)"
	}

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

update -NoCheckChocoVersion
