$ErrorActionPreference = 'Stop'
import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

# $releases = 'https://github.com/brave/brave-browser/releases/latest'
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
	Write-Verbose 'Get files'
	$page = Invoke-WebRequest -Uri "https://github.com/brave/brave-browser/tags"
	$tag = ($page.Links | Where-Object {$_.href -match "tag/v"} | Select-Object -First 1).href.split('/')[-1]
	try {
		$tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo -Tag $tag
		$url32 = $tags.assets.browser_download_url | Where-Object {$_ -match ".exe$"} | Where-Object { $_ -match 'StandaloneSilent'} | Where-Object {$_ -notmatch '32.exe'} | Where-Object {$_ -notmatch 'Arm64'}
		Update-Metadata -key "releaseNotes" -value $tags.html_url

		Write-Verbose 'Checking version'
		$version=($tags.name.Split(' ')[1]).replace('v','')
	}
	catch {
		$version = "0.0"
	}

	if($version -eq "0.0") {}
	elseif($tags.prerelease -eq $true) {
		$version = "$version-nightly"
	} elseif ($url32 -match 'Nightly') {
		$version = "$version-nightly"
	} else {
		$version = '0.0'
	}
	Write-Output "Version : $version"

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

try {
	update -ChecksumFor 32
} catch {
	$ignore = "URL syntax is invalid:"
	if ($_ -match $ignore) { Write-Output $ignore; 'ignore' } else { throw $_ }
}
