$ErrorActionPreference = 'Stop'
import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$Owner = "brave"
$repo = "brave-browser"

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url32\s*=\s*)('.*')"		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum32\s*=\s*)('.*')"	= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType32\s*=\s*)('.*')"	= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	Write-Verbose 'Fetching GitHub releases'

	# Use the GitHub API to get recent releases and find the latest prerelease (nightly).
	# The old approach scraped the HTML tags page and took the first tag, which could be a
	# stable release — leaving $url32 null and causing AU "URL check" failures.
	$headers = @{ 'User-Agent' = 'chocolatey-au-updater/1.0' }
	$releases = Invoke-RestMethod "https://api.github.com/repos/$Owner/$repo/releases?per_page=20" -Headers $headers
	$nightlyRelease = $releases | Where-Object { $_.prerelease -eq $true } | Select-Object -First 1

	if (-not $nightlyRelease) {
		Write-Warning "No nightly prerelease found in last 20 releases"
		return
	}

	$url32 = $nightlyRelease.assets.browser_download_url |
		Where-Object { $_ -match "\.exe$" } |
		Where-Object { $_ -match 'StandaloneSilent' } |
		Where-Object { $_ -notmatch '32\.exe' } |
		Where-Object { $_ -notmatch 'Arm64' } |
		Select-Object -First 1

	if (-not $url32) {
		Write-Warning "No StandaloneSilentNightly exe asset found in release $($nightlyRelease.tag_name)"
		return
	}

	Update-Metadata -key "releaseNotes" -value $nightlyRelease.html_url

	# Extract version from tag name (e.g. "v1.93.7" -> "1.93.7-nightly")
	$version = ($nightlyRelease.tag_name -replace '^v', '') + '-nightly'

	Write-Output "Version : $version"
	Write-Output "URL32   : $url32"

	return @{ Version = $version; URL32 = $url32 }
}

try {
	update -ChecksumFor 32
} catch {
	$ignore = "URL syntax is invalid:"
	if ($_ -match $ignore) { Write-Output $ignore; 'ignore' } else { throw $_ }
}
