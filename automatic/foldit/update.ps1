$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$release = 'https://files.ipd.uw.edu/pub/foldit/Foldit-win_x64.exe'

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
		}
	}
}

function global:au_GetLatest {
	$clnt = new-object System.Net.WebClient;
	$clnt.OpenRead($release).Close();
	$version=$([datetime]$clnt.ResponseHeaders["Last-Modified"];).ToString("0.0.yyyyMMdd")
	Write-Output "Version : $version"
	$url32 = $release

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion
