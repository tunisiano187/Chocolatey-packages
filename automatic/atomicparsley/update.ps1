import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$releases = 'https://github.com/wez/atomicparsley/releases/latest'
$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 2

function global:au_SearchReplace {
	@{
    	".\legal\VERIFICATION.txt" = @{
    		"(?i)(^\s*url(32)?\:\s*).*"        = "`${1}<$($Latest.URL32)>"
    		"(?i)(^\s*checksum(32)?\:\s*).*"   = "`${1}$($Latest.Checksum32)"
    		"(?i)(^\s*checksum\s*type\:\s*).*" = "`${1}$($Latest.ChecksumType32)"
    	}
	}
}

function global:au_BeforeUpdate {
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $Latest.URL32 -keep
	$File = "tools\AtomicParsleyWindows.zip"
	Move-Item -Path $FileVersion.TempFile -Destination $File
	$Latest.Checksum32 = $FileVersion.Checksum
	$Latest.ChecksumType32 = $FileVersion.checksumType
}

function global:au_AfterUpdate($Package) {
  Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo -Latest
	$url32 = $tags.assets.browser_download_url | Where-Object {$_ -match "Windows.zip$"}
	$version = "$($tags.tag_name.Replace('v','').split('.')[0]).$($tags.tag_name.Replace('v','').split('.')[1])"
	Update-Metadata -key "releaseNotes" -value $tags.html_url
	Update-Metadata -key "licenseUrl" -value $((Get-GitHubLicense -OwnerName $Owner -RepositoryName $repo).download_url)
	if($tags.prerelease -match "true") {
    	$date = $tags.published_at.ToString("yyyyMMdd")
    	$version = "$version-pre$($date)"
	}
	Invoke-WebRequest -Uri $((Get-GitHubLicense -OwnerName $Owner -RepositoryName $repo).download_url) -OutFile "legal\LICENSE.txt"

  	$Latest = @{ URL32 = $url32; Version = $Version }
	return $Latest
}

update -ChecksumFor none
