$ErrorActionPreference = 'Stop'
import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$releases = 'https://sourceforge.net/projects/freeplane/rss?path=/freeplane%20stable'

function global:au_SearchReplace {
	@{
		'.\legal\VERIFICATION.txt' = @{
			"(?i)(\s+x32:).*"                   = "`${1} $($Latest.URL32)"
			"(?i)(Get-RemoteChecksum).*"        = "`${1} $($Latest.URL32)"
			"(?i)(\s+checksum32:).*"            = "`${1} $($Latest.Checksum32)"
		}
	}
}

function global:au_BeforeUpdate {
	# Update license from the current stable branch
	$version = $Latest.Version
	$majorMinor = ($version -split '\.')[0..1] -join '.'
	$licenseBranch = "$majorMinor.x"
	try {
		Invoke-WebRequest -Uri "https://raw.githubusercontent.com/freeplane/freeplane/$licenseBranch/license.txt" -OutFile "legal\LICENSE.txt" -UseBasicParsing -ErrorAction Stop
	} catch {
		# Fall back to 1.12.x if the branch-specific URL fails
		Invoke-WebRequest -Uri "https://raw.githubusercontent.com/freeplane/freeplane/1.12.x/license.txt" -OutFile "legal\LICENSE.txt" -UseBasicParsing
	}
	# Clean up any old installer files before downloading the new one
	Get-ChildItem "tools\*.exe" -ErrorAction SilentlyContinue | Remove-Item -Force

	# Chocolatey's own guidance is to prefer embedding the installer in the package when the
	# packaged .nupkg stays well under ~200MB (freeplane's installer is ~107MB), rather than
	# downloading it fresh at install time -- so this package embeds again, as it originally did.
	# SourceForge's "direct download" URLs end in a trailing "/download" segment -- strip it to
	# get the real file name instead of assuming a hardcoded one.
	$fileName = ($Latest.URL32 -replace '/download$', '').Split('/')[-1]
	if (-not $fileName) { $fileName = "freeplane-$($Latest.Version).exe" }
	# Use an absolute path, not a bare "tools\..." relative one: [System.IO.File]::OpenRead()
	# below resolves relative paths against .NET's process working directory, which can differ
	# from PowerShell's own location (confirmed live: it resolved to C:\Windows\system32\tools\...
	# during an AU run, throwing DirectoryNotFoundException even though the same relative path
	# worked fine for Invoke-WebRequest -OutFile and Get-FileHash just lines below, since those
	# are PowerShell cmdlets that respect $PWD). $PSScriptRoot is this script's own directory and
	# is unaffected by whatever the current process directory happens to be.
	$destPath = Join-Path $PSScriptRoot "tools\$fileName"

	# SourceForge's automatic mirror selection is unreliable from CI/datacenter IPs: it can serve
	# a small HTML "choose a mirror" page instead of redirecting to the real binary. It's
	# consistently reliable from residential/office IPs, which is why this doesn't reproduce
	# locally. Retry the same URL a few times with a short delay -- each retry gets a fresh mirror
	# assignment, improving the odds of landing on one that works for this IP (verified live: a
	# pinned "?use_mirror=" query parameter does NOT actually pin anything, SourceForge silently
	# reassigns regardless -- so plain retries are what actually help, not mirror pinning).
	# The RSS feed's <link> is the "/download" auto-mirror-select endpoint. Fetching that exact
	# URL from this CI's datacenter IP consistently (not just occasionally) returns SourceForge's
	# HTML "choose a mirror" interstitial on every one of 5 retries -- confirmed live, so this
	# isn't the intermittent flakiness the retry loop was originally written for. Stripping the
	# trailing "/download" and fetching the bare file URL instead avoids that bot-gated endpoint;
	# SourceForge still 302-redirects it straight to a mirror, which Invoke-WebRequest follows
	# automatically, and it isn't subject to the same automation block.
	$fetchUrl = $Latest.URL32 -replace '/download$', ''

	# 2026-09-04/05 postmortem: a prior version of this function sent a spoofed browser
	# User-Agent here ('Chrome/120...') as a further mitigation attempt. DO NOT reintroduce that.
	# AppVeyor's daily runs had failed identically and harmlessly against this same bare URL every
	# single day from 23 Aug through 3 Sep (plain HTTP 200 "choose a mirror" HTML page, no
	# Cloudflare challenge markers) -- confirmed by reading each day's job log directly. The very
	# next run after the User-Agent change merged (4 Sep 16:13 UTC) started getting served an
	# active Cloudflare JS "managed challenge" (`_cf_chl_opt`, "Just a moment...") instead, and it
	# stayed elevated across every subsequent run checked over the following 16+ hours (different
	# cf-ray each time, so not a one-off blip). Sending a browser UA without the matching TLS/JA3
	# fingerprint a real browser would have is a textbook bot-management red flag -- it very
	# likely made Cloudflare's scoring for this IP/path *worse*, not better. Leave the default
	# PowerShell UA (or none) rather than trying to impersonate a browser again.
	$maxAttempts = 5
	$validExe = $false
	$lastFailureDetail = $null
	for ($attempt = 1; $attempt -le $maxAttempts; $attempt++) {
		try {
			$response = Invoke-WebRequest -Uri $fetchUrl -OutFile $destPath -UseBasicParsing -ErrorAction Stop -PassThru
			$lastFailureDetail = "HTTP $($response.StatusCode), Content-Type: $($response.Headers['Content-Type']), $((Get-Item $destPath).Length) bytes"
		} catch {
			$lastFailureDetail = "request failed: $_"
			Start-Sleep -Seconds 3
			continue
		}
		if (-not (Test-Path $destPath) -or (Get-Item $destPath).Length -eq 0) {
			$lastFailureDetail = "empty file ($lastFailureDetail)"
			Start-Sleep -Seconds 3
			continue
		}
		# A non-empty file isn't proof of a valid installer: SourceForge occasionally serves a
		# small HTML page (bot-block / mirror-choice interstitial) instead of the binary, which
		# still has a non-zero size. Confirm it's actually a Windows PE executable by checking for
		# the 'MZ' DOS header magic bytes.
		$header = [byte[]]::new(2)
		$stream = [System.IO.File]::OpenRead($destPath)
		try { $stream.Read($header, 0, 2) | Out-Null } finally { $stream.Close() }
		if ($header[0] -eq 0x4D -and $header[1] -eq 0x5A) { $validExe = $true; break }
		$lastFailureDetail = "missing 'MZ' header ($lastFailureDetail)"
		Start-Sleep -Seconds 3
	}
	if (-not $validExe) {
		throw "Downloaded file is not a valid Windows executable after $maxAttempts attempts: $destPath (from $fetchUrl). Last failure: $lastFailureDetail"
	}

	$Latest.Checksum32 = (Get-FileHash -Path $destPath -Algorithm SHA512).Hash
	$Latest.ChecksumType32 = 'sha512'
	# The actual root cause behind every previous "no exe in tools\" moderation failure on this
	# package (#4249/#4301/#4312 history): scripts/Invoke-VirusTotalScan.ps1 (called from
	# au_AfterUpdate below) treats an unset $Latest.FileName32 as "no file has been tracked yet
	# for this package" -- it re-downloads via its own Get-RemoteFiles purely to scan it, then
	# DELETES whatever it downloaded once the scan is done. That's correct for download-on-install
	# packages, Where-Object the scanned file is meant to be disposable scratch data -- but freeplane
	# never set FileName32, so the shared script wrongly treated its real, already-embedded exe
	# the same way: scanned it, then deleted it right after au_BeforeUpdate had placed it. AU
	# still reported success since nothing threw. This is the exact same bug just found and fixed
	# for `osfmount`. Setting FileName32 marks the file as pre-existing, so the scan uses it
	# directly and skips the delete-after-scan step.
	$Latest.FileName32 = $fileName
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	[xml]$rss = Invoke-WebRequest -Uri $releases | Select-Object -ExpandProperty Content
	# Select the standard (non-touchscreen, non-archive) Setup .exe
	$items = $rss.rss.channel.item | Where-Object {
		($_.link -like "*Freeplane-Setup-[0-9]*.exe/download*") -and
		($_.link -notlike "*/archive/*") -and
		($_.link -notlike "*touchscreen*")
	} | Select-Object -First 1

	$url32 = $items.link
	$versionMatch = [regex]::Match($url32, 'Freeplane-Setup-(\d+\.\d+(?:\.\d+)?(?:-u\d+)?)\.exe')
	$version = $versionMatch.Groups[1].Value

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor none -NoCheckChocoVersion
