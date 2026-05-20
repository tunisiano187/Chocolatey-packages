$ErrorActionPreference = 'Stop'
import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url32\s*=\s*)'.*'"		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum32\s*=\s*)'.*'"	= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType32\s*=\s*)'.*'"	= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
    # Enumerate the stable directory to find the latest versioned .exe
    # URL pattern: https://download.mediathekview.de/stabil/MediathekView-{version}-win.exe
    $stabilDir = 'https://download.mediathekview.de/stabil/'

    try {
        $page = Invoke-WebRequest -Uri $stabilDir -UseBasicParsing

        # Collect all versioned windows exe links (exclude 'latest' and 'arm64')
        $versionedExes = $page.Links | Where-Object {
            $_.href -match 'MediathekView-[\d.]+-win\.exe$' -and $_.href -notmatch 'latest'
        }

        if (-not $versionedExes) {
            throw "Could not find versioned win exe on $stabilDir"
        }

        # Sort by version descending and take the newest
        $latest = $versionedExes | ForEach-Object {
            $m = [regex]::Match($_.href, 'MediathekView-([\d.]+)-win\.exe')
            [pscustomobject]@{ href = $_.href; version = $m.Groups[1].Value }
        } | Sort-Object { [Version]$_.version } -Descending | Select-Object -First 1

        $version = $latest.version
        $url32 = "https://download.mediathekview.de$($latest.href)"
        if ($latest.href -match '^https?://') { $url32 = $latest.href }

        return @{
            Version = $version
            URL32   = $url32
        }
    }
    catch {
        throw "Error updating MediathekView: $_"
    }
}

update -ChecksumFor 32
