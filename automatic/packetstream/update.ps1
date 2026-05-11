$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

# packetstream.software.informer.com is Cloudflare-blocked.
# The S3 "latest" URL serves the current release; version is extracted from the exe.
$url32 = 'https://s3-us-west-2.amazonaws.com/packetstream-releases/latest/PacketStream.exe'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumtype\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$tempFile = Join-Path $env:TEMP "PacketStream_version_check.exe"
	try {
		Invoke-WebRequest -Uri $url32 -OutFile $tempFile -UseBasicParsing
		$version = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($tempFile).FileVersion.Trim()
		if (-not $version) { throw "Could not extract version from PacketStream.exe" }
	} finally {
		if (Test-Path $tempFile) { Remove-Item $tempFile -Force -ErrorAction SilentlyContinue }
	}
	return @{ URL32 = $url32; Version = $version }
}

update -ChecksumFor 32
