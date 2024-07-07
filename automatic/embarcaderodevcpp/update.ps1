$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://api.github.com/repos/Embarcadero/Dev-Cpp/releases/latest'
$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 2

function global:au_SearchReplace {
	@{
		"$($Latest.PackageName).nuspec" = @{
			"(\<copyright\>).*?(\</copyright\>)" 	= "`${1}Embarcadero $((Get-Date).year)`$2"
		}
		".\tools\VERIFICATION.txt" = @{
			"(?i)(\s+x32:).*"                   = "`${1} $($Latest.URL32)"
			"(?i)(Get-RemoteChecksum).*"        = "`${1} $($Latest.URL32)"
			"(?i)(\s+checksum32:).*"            = "`${1} $($Latest.Checksum32)"
		  }
	}
}

function global:au_BeforeUpdate {
	Invoke-WebRequest -Uri "https://github.com/Embarcadero/Dev-Cpp/blob/master/COPYING.txt" .\tools\LICENSE.txt
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo -Latest
	$url32 = $tags.assets.browser_download_url | Where-Object {$_ -match ".exe$"} | Where-Object {$_ -match "GCC"}
	$version = $tags.tag_name.Replace('v','')
	Update-Metadata -key "releaseNotes" -value $tags.html_url
	if($tags.prerelease -match "true") {
		$date = $tags.published_at.ToString("yyyyMMdd")
		$version = "$version-pre$($date)"
	}
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $url32 -keep
	Move-Item $FileVersion.TempFile -Destination "tools\$($url32.Split('/')[-1])"

	$Latest = @{ URL32 = $url32; Checksum32 = $FileVersion.Checksum; ChecksumType32 = $FileVersion.ChecksumType; Version = $version }
	return $Latest
}

update -ChecksumFor none -NoCheckChocoVersion
