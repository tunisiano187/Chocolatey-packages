$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'https://api.github.com/repos/kvirc/KVIrc/releases/latest'
$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 2

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo | select-object -First 1
	$url32 = $tags.assets.browser_download_url | Where-Object {$_ -match ".exe$"} | select-object -First 1
	$version = ($tags.tag_name -split 'v|/' | Where-Object { $_ -match "."}).Trim()
	Update-Metadata -key "releaseNotes" -value $tags.html_url
	$url32beta = "https://nightly.kvirc.net$((Invoke-WebRequest -Uri "https://nightly.kvirc.net/win-x86_64/" -UseBasicParsing).Links.href | Where-Object {$_ -match ".exe$"} | select-object -Last 1)"
	$versionbeta = ($url32beta -split '/' | Select-Object -Last 1).replace('KVIrc-','').replace('.exe','')
	if($versionbeta -ge $version) {
		$version = $versionbeta
		$url32 = $url32beta
	}

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update
