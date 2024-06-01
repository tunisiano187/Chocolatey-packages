$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://api.github.com/repos/LADSoft/OrangeC/releases/latest'
$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 2

function global:au_SearchReplace {
    @{
        ".\legal\VERIFICATION.txt" = @{
			"(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$($Latest.ReleaseUri)>"
			"(?i)(^\s*url(32)?\:\s*).*"         = "`${1}<$($Latest.URL32)>"
			"(?i)(^\s*checksum(32)?\:\s*).*"    = "`${1}$($Latest.Checksum32)"
    		"(?i)(^\s*checksum\s*type\:\s*).*" = "`${1}$($Latest.ChecksumType32)"
        }
    }
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
    $tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo -Latest
	$url32 = $tags.assets.browser_download_url | Where-Object {$_ -match "Windows"}
    Update-Metadata -key "releaseNotes" -value $tags.html_url
	$version = $tags.tag_name.Replace('v','').Split('-')[-1]
    $File = "tools\$($url32.Split('/')[-1])"
    Invoke-WebRequest -Uri $url32 -OutFile $File
    $checksum = (Get-FileHash -Path $File -Algorithm $env:ChocolateyChecksumType).Hash
    if($tags.tag_name -match $version) {
        if($tags.prerelease -match "true") {
            $date = $tags.published_at.ToString("yyyyMMdd")
            $version = "$version-pre$($date)"
        }
    }

    return @{ URL32 = $url32; Version = $version; ReleaseUri = $tags.html_url; Checksum32 = $checksum; ChecksumType32 = $env:ChocolateyChecksumType }
}

update -ChecksumFor none -NoCheckChocoVersion