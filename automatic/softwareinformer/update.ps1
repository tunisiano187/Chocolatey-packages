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
		Invoke-WebRequest -Uri $url32 -OutFile $tempFile -UseBasicParsing
		$version = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($tempFile).FileVersion.Trim()
		if (-not $version) { throw "Could not extract version from siinst.exe" }
	} finally {
		if (Test-Path $tempFile) { Remove-Item $tempFile -Force -ErrorAction SilentlyContinue }
	}
	return @{ URL32 = $url32; Version = $version }
}

update -ChecksumFor 32
