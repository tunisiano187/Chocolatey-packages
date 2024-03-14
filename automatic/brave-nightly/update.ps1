$ErrorActionPreference = 'Stop'
import-module au

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
	$tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo -Latest
	$url32 = $tags.assets.browser_download_url | Where-Object {$_ -match ".exe$"} | Where-Object { $_ -match 'StandaloneSilent'} | Where-Object {$_ -notmatch '32.exe'} | Where-Object {$_ -notmatch 'Arm64'}
	Update-Metadata -key "releaseNotes" -value $tags.html_url

	Write-Verbose 'Checking version'
	$version=($tags.name.Split(' ')[1]).replace('v','')

	if($tags.prerelease -eq $true) {
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

update -ChecksumFor 32
