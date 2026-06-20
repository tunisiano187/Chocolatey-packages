$ErrorActionPreference = 'Stop'
import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

# software-informer.informer.com is Cloudflare-blocked.
# files.informer.com/siinst.exe is a direct CDN link that bypasses Cloudflare;
# version is extracted from the exe's FileVersionInfo.

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
     }
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$url32    = "https://files.informer.com/siinst.exe"
	$tempFile = Join-Path $env:TEMP "siinst_version_check.exe"
	try {
		$response = Invoke-WebRequest -Uri $url32 -OutFile $tempFile -UseBasicParsing -PassThru
		if ($response.StatusCode -ne 200) {
			throw "Download failed with HTTP status $($response.StatusCode)"
		}
		# Validate we got a PE binary (MZ header), not an error page
		$header = [System.IO.File]::ReadAllBytes($tempFile) | Select-Object -First 2
		if ($header[0] -ne 0x4D -or $header[1] -ne 0x5A) {
			throw "Downloaded file is not a valid PE executable (got an error page?)"
		}
		$versionInfo = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($tempFile)
		$fileVersion = $versionInfo.FileVersion
		if (-not $fileVersion) {
			throw "FileVersion is null in siinst.exe — the file may be corrupt or an error page"
		}
		$version = $fileVersion.Trim()
		if (-not $version) { throw "Could not extract version from siinst.exe" }
	} finally {
		if (Test-Path $tempFile) { Remove-Item $tempFile -Force -ErrorAction SilentlyContinue }
	}
	return @{ URL32 = $url32; Version = $version }
}

update -ChecksumFor 32
