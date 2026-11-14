$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

# Versions are scraped from the main DDU page (no Cloudflare challenge).
# Downloads are served from download.wagnardsoft.com which enforces a hotlink check:
# AU's built-in URL validator/downloader (invoked by -ChecksumFor) returns 403 without
# a Referer header. We handle the download manually in au_BeforeUpdate with the correct
# Referer and User-Agent, then use -ChecksumFor none so AU never touches the URL bare.
$releases = "https://www.wagnardsoft.com/display-driver-uninstaller-ddu"

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
			"(^[$]referer\s*=\s*)('.*')"      = "`$1'$($Latest.Referer)'"
		}
	}
}

function global:au_BeforeUpdate($Package) {
	# Wagnardsoft enforces hotlink protection: visit the page first to warm the
	# session, then download the exe with a Referer header attached.
	$ua = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36'
	$null = Invoke-WebRequest -Uri $Latest.Referer -UseBasicParsing -UserAgent $ua
	$tmpFile = [System.IO.Path]::GetTempFileName()
	Invoke-WebRequest -Uri $Latest.URL32 `
		-Headers @{ Referer = $Latest.Referer } `
		-UserAgent $ua `
		-OutFile $tmpFile `
		-UseBasicParsing
	$hash = Get-FileHash $tmpFile -Algorithm SHA256
	$Latest.Checksum32     = $hash.Hash.ToLower()
	$Latest.ChecksumType32 = 'sha256'
	Remove-Item $tmpFile
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

	$url32   = "https://download.wagnardsoft.com/DDU/DDU%20v$version.exe"
	$referer = $releases

	return @{ URL32 = $url32; Referer = $referer; Version = $version }
}


update -ChecksumFor none
