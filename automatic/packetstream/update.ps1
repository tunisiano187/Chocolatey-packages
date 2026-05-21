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
	. ..\..\scripts\Invoke-VirusTotalScan.ps1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	# The PacketStream.exe has no embedded FileVersion/ProductVersion.
	# Use the S3 ETag as a change-detection proxy and derive a date-based version
	# from the Last-Modified header (format: YYYY.M.D.0).
	$response = Invoke-WebRequest -Uri $url32 -Method Head -UseBasicParsing
	$lastModified = $response.Headers['Last-Modified']
	if (-not $lastModified) {
		throw "No Last-Modified header on PacketStream S3 URL"
	}
	$dt = [datetime]::Parse($lastModified)
	$version = "$($dt.Year).$($dt.Month).$($dt.Day).0"

	return @{ URL32 = $url32; Version = $version }
}

update -ChecksumFor 32
