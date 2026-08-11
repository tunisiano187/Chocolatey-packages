$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

function global:au_SearchReplace {
	@{
		"legal\VERIFICATION.txt"      = @{
			"(?i)(x86:).*"        				= "`${1} $($Latest.URL32)"
			"(?i)(checksum:).*" 				= "`${1} $($Latest.Checksum32)"
			"(?i)(checksumtype:).*" 			= "`${1} $($Latest.ChecksumType32)"
		}
	}
}

function global:au_BeforeUpdate {
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $Latest.URL32 -keep
	$destPath = "tools\osfmount.exe"
	# Without -Force, Move-Item silently no-ops (well, throws a *non-terminating* error) if
	# $destPath already exists -- e.g. left over from a previous run on a reused AppVeyor
	# workspace. Combined with $ErrorActionPreference not reliably propagating into this
	# global function (it's invoked from deep inside the AU module, in a different scope),
	# that non-terminating error was getting swallowed: au_BeforeUpdate would report success,
	# choco pack would silently build a .nupkg with no tools\osfmount.exe at all, and AU would
	# push it -- which is exactly what happened for v3.2.1000/3.2.1001 (confirmed by pulling
	# the actual pushed .nupkg from chocolatey.org: it contains chocolateyinstall.ps1 but no
	# osfmount.exe). -Force makes the move actually succeed instead of silently no-op.
	Move-Item -Path $FileVersion.TempFile -Destination $destPath -Force
	if (-not (Test-Path $destPath) -or (Get-Item $destPath).Length -eq 0) {
		throw "osfmount.exe failed to land in tools\ after Move-Item: $destPath (from $($Latest.URL32))"
	}
	$Latest.Checksum32 = $FileVersion.Checksum
	$Latest.ChecksumType32 = $FileVersion.checksumType
	# The real bug: scripts/Invoke-VirusTotalScan.ps1 (called from au_AfterUpdate) treats an
	# unset $Latest.FileName32 as "no file has been tracked yet" -- it re-downloads via its own
	# Get-RemoteFiles into tools\ for scanning purposes, then deletes whatever it downloaded
	# afterward (correct behavior for download-on-install packages, Where-Object that's meant to be
	# scratch data). Because osfmount never set FileName32, that cleanup deleted this package's
	# real, already-embedded osfmount.exe right after au_BeforeUpdate placed it -- AU still
	# reported "updated ... and pushed" since nothing threw, but the pushed .nupkg had no exe
	# (confirmed by downloading it directly from chocolatey.org). Setting FileName32 here tells
	# Invoke-VirusTotalScan this file already exists and must be preserved, not scratch-cleaned.
	$Latest.FileName32 = 'osfmount.exe'
}

function global:au_AfterUpdate($Package) {
	. ..\..\scripts\Invoke-VirusTotalScan.ps1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$url32 = 'https://www.osforensics.com/downloads/osfmount.exe'
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $url32
	$version = $FileVersion.Version

	return @{ URL32 = $url32; Version = $version }
}

update -NoCheckUrl -ChecksumFor none -NoCheckChocoVersion
