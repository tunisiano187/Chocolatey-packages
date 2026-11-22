$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'https://minepi.com/pi-blockchain/pi-node/'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	. ..\..\scripts\Invoke-VirusTotalScan.ps1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	# minepi.com/pi-blockchain/pi-node/ now 301-redirects to minepi.com/pi-node/ -- follow it
	# with -UseBasicParsing's default redirect handling (Invoke-WebRequest follows 3xx
	# automatically), so $releases itself doesn't need to change.
	# minepi.com is behind Cloudflare and intermittently rejects requests with no User-Agent
	# at all (PowerShell's default) -- confirmed live, a browser UA gets a normal 200 with the
	# .exe link present. Without it, $url silently ends up empty and the error below reports an
	# empty filename instead of the real cause.
	$ua = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36'
	$url = ((Invoke-WebRequest -Uri $releases -UseBasicParsing -UserAgent $ua).Links | Where-Object {$_ -match ".exe"} | Select-Object -First 1).href
	$filename = [System.IO.Path]::GetFileName($url)

	# The installer filename changed from space/%20-separated ("Pi Network Setup 0.6.2.exe")
	# to dot-separated ("Pi.Network.Setup.0.6.2.exe") -- confirmed live. [\s%20]+ (a character
	# class, not the literal string "%20") never matched a literal ".", so $version was never
	# assigned and AU's own validation threw the opaque "Invalid version: " (empty). Accept a
	# dot too, and fail loudly if the filename format changes again instead of silently
	# returning an unset version.
	if ($filename -match "Setup[\s.%]*([0-9]+\.[0-9]+\.[0-9]+(?:\.[a-zA-Z0-9]+)?)\.exe$") {
    	$version = $matches[1]
	} else {
		throw "Could not extract version from installer filename: $filename"
	}

	$Latest = @{ URL32 = $url; Version = $version }
	return $Latest
}

update -ChecksumFor 32
