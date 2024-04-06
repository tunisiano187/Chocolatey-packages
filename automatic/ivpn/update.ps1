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
	$url32 = ($tags.body.Split('
') | Where-Object {$_ -match '.exe'}).split('(|)')[-2]
	$checksumType32 = "SHA256"
	$checksum32 = Get-RemoteChecksum -Url $url32 -Algorithm $checksumType32
	$version = $tags.tag_name -split 'v|/' | select-object -Last 1
	Update-Metadata -key "releaseNotes" -value $tags.html_url
	if($tags[0].prerelease -match "true") {
		$date = $tags[0].published_at.ToString("yyyyMMdd")
		$version = "$version-pre$($date)"
	}

	$Latest = @{ URL32 = $url32; CHECKSUM32 = $checksum32; CHECKSUMTYPE32 = $checksumType32; Version = $version }
	return $Latest
}

try {
    update
} catch {
    $ignore = "You cannot call a method on a null-valued expression."
    if ($_ -match $ignore) { Write-Output $ignore; 'ignore' } else { throw $_ }
}