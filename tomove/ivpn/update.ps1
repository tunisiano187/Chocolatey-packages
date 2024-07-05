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
			"(\<copyright\>).*?(\</copyright\>)" 	= "`${1}IVPN.net $((Get-Date).year)`$2"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo | select-object -First 1
	$page = Invoke-WebRequest -Uri "https://www.ivpn.net/en/apps-windows/" -UseBasicParsing
	$url32 = ($page.Links | Where-Object {$_.href -match ".exe$"} | Select-Object -First 1).href
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $url32
	$version = ($url32 -split 'v|/' | select-object -Last 1).trim('.exe')
	if($tags[0].prerelease -match "true") {
		$date = $tags[0].published_at.ToString("yyyyMMdd")
		$version = "$version-pre$($date)"
	}

	$Latest = @{ URL32 = $url32; CHECKSUM32 = $FileVersion.Checksum; CHECKSUMTYPE32 = $FileVersion.ChecksumType; Version = $version }
	return $Latest
}

update