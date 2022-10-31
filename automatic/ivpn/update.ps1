$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://api.github.com/repos/ivpn/desktop-app/releases/latest'
$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 2

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
		}
		"$($Latest.PackageName).nuspec" = @{
			"(\<releaseNotes\>).*?(\</releaseNotes\>)" 	= "`${1}$($Latest.ReleaseNotes)`$2"
			"(\<copyright>\>IVPN.net).*?(\</releaseNotes\>)"	= "`${1}$($Latest.ReleaseNotes)`$2"
		}
	}
}

function global:au_BeforeUpdate {
	Import-Module VirusTotalAnalyzer -NoClobber -Force
	$vt = (Get-VirusScan -ApiKey $env:VT_APIKEY -Url $Latest.URL32).data.attributes.reputation
	if ( $vt -gt 5 ) {
	  Write-Error "Ignoring $($Latest.PackageName) package due to virus total results - $vt positives"
	  return 'ignore'
	}
}

function global:au_GetLatest {
	$tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo
	$url32 = ($tags[0].body.Split('
') | Where-Object {$_ -match '.exe'}).split('(|)')[-2]
	$version = $tags[0].tag_name -split 'v|/' | select-object -Last 1
	$releaseNotes="https://github.com/$($Owner)/$($repo)/releases/tag/$($tags[0].tag_name)"
	if($tags[0].prerelease -match "true") {
		$date = $tags[0].published_at.ToString("yyyyMMdd")
		$version = "$version-pre$($date)"
	}

	$Latest = @{ URL32 = $url32; Version = $version; ReleaseNotes = $releaseNotes }
	return $Latest
}

update -NoCheckChocoVersion