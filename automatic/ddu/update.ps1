$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

# Changed from forums (Cloudflare IUAM) to the main DDU page which is accessible.
# Direct download URL pattern: https://www.wagnardsoft.com/DDU/download/DDU%20v{version}.exe
$releases = "https://www.wagnardsoft.com/display-driver-uninstaller-ddu"

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
			"(^[$]referer\s*=\s*)('.*')" = "`$1'$($Latest.Referer)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	. ..\..\scripts\Invoke-VirusTotalScan.ps1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$page = Invoke-WebRequest -Uri $releases -UseBasicParsing -UserAgent 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36'

	# Extract version from content links like /content/Download-Display-Driver-Uninstaller-DDU-18152
	# Pattern: DDU-{2-digit-major}{minor}{patch}{build} e.g. DDU-18152 => 18.1.5.2
	if ($page.Content -match '/content/Download-Display-Driver-Uninstaller-DDU-(\d{2})(\d)(\d)(\d+)') {
		$version = "$($Matches[1]).$($Matches[2]).$($Matches[3]).$($Matches[4])"
	} elseif ($page.Content -match '[Vv](\d{2}\.\d+\.\d+\.\d+)') {
		$version = $Matches[1]
	} else {
		throw "Could not extract DDU version from $releases"
	}

	$url32   = "https://www.wagnardsoft.com/DDU/download/DDU%20v$version.exe"
	$referer = $releases

	return @{ URL32 = $url32; Referer = $referer; Version = $version }
}


update -ChecksumFor 32
