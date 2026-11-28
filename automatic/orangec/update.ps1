$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

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

function global:au_BeforeUpdate {
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $Latest.URL32 -keep
	# Get-FileVersion derives .FileName from Chocolatey's own Get-WebFileName, which can fail to
	# resolve a proper name/extension for a GitHub release asset URL and fall back to a default
	# that has no extension at all (its own default-name guess for a non-SourceForge URL takes the
	# *second-to-last* path segment, e.g. "Orange-C-v7.20.1" instead of "WindowsInstaller7201.exe").
	# chocolateyinstall.ps1 picks up the installer via `Get-ChildItem -Filter "*.exe"`, so a
	# drop with no (or the wrong) extension leaves it with nothing to find - confirmed: v7.20.1
	# failed chocolatey.org's verification testing with "Package parameters incorrect, either File
	# or File64 must be specified" because $installer came back empty. Derive the destination name
	# directly from the URL's own last path segment instead of trusting the dynamically detected one.
	$fileName = Split-Path -Leaf $Latest.URL32
	Move-Item -Path $FileVersion.TempFile -Destination "tools\$fileName" -Force
	if (-not (Test-Path "tools\$fileName")) {
		throw "tools\$fileName is missing after Move-Item - chocolateyinstall.ps1 would have no installer to find"
	}
	$Latest.Checksum32 = $FileVersion.Checksum
	$Latest.ChecksumType32 = $FileVersion.checksumType
	$Latest.FileName32 = $fileName
}

function global:au_AfterUpdate($Package) {
	Import-Module ..\..\scripts\au_extensions.psm1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
    $tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo -Latest
	$url32 = $tags.assets.browser_download_url | Where-Object {$_ -match "Windows"}
    Update-Metadata -key "releaseNotes" -value $tags.html_url
	$version = $tags.tag_name.Replace('v','').Split('-')[-1]
    if($tags.tag_name -match $version) {
        if($tags.prerelease -match "true") {
            $date = $tags.published_at.ToString("yyyyMMdd")
            $version = "$version-pre$($date)"
        }
    }

    return @{ URL32 = $url32; Version = $version; ReleaseUri = $tags.html_url }
}

update -ChecksumFor none
