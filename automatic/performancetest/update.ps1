$ErrorActionPreference = 'Stop'
import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$releases = "https://www.passmark.com/products/performancetest/history.php"
$downloadUrl = "https://www.passmark.com/downloads/PerformanceTest_Windows_x86-64.exe"

function global:au_AfterUpdate($Package) {
	. ..\..\scripts\Invoke-VirusTotalScan.ps1
	Invoke-VirusTotalScan $Package
}

function global:au_BeforeUpdate {
	# Passmark requires a browser User-Agent and Referer to allow direct downloads from CI
	$headers = @{
		'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'
		'Referer'    = 'https://www.passmark.com/products/performancetest/download.php'
	}
	$tempFile = Join-Path $env:TEMP 'PerformanceTest_Windows_x86-64.exe'
	Invoke-WebRequest -Uri $Latest.URL64 -OutFile $tempFile -Headers $headers -UseBasicParsing
	$Latest.Checksum64 = (Get-FileHash -Path $tempFile -Algorithm SHA256).Hash
	$Latest.ChecksumType64 = 'sha256'
	Remove-Item $tempFile -Force
}

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"          = "`$1'$($Latest.URL64)'"
			"(^[$]checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum64)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
		}
	}
}

function global:au_GetLatest {
	# Scrape the version history page instead of downloading the exe (passmark blocks direct exe downloads from CI)
	$page = Invoke-WebRequest -Uri $releases -UseBasicParsing
	$match = [regex]::Match($page.Content, 'V(\d+\.\d+) Build (\d+)')
	if (-not $match.Success) { throw "Could not parse version from $releases" }
	$versionBase = $match.Groups[1].Value   # e.g. "11.1"
	$build       = $match.Groups[2].Value   # e.g. "1011"
	$version     = "$versionBase.$build.0"  # e.g. "11.1.1011.0"

	return @{ URL64 = $downloadUrl; Version = $version }
}

update -ChecksumFor none
