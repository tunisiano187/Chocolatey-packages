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
    $releasesPage = 'https://mediathekview.de/download/'

    try {
        # Download the releases page to find the latest version
        $page = Invoke-WebRequest -Uri $releasesPage -UseBasicParsing

        # Look for the latest stable version (pattern like 14.5.0)
        $versionPattern = '(\d+\.\d+\.\d+)'
        $version = [regex]::Matches($page.Content, $versionPattern) | Select-Object -First 1 | ForEach-Object { $_.Groups[1].Value }

        if (-not $version) {
            throw "Unable to find version from $releasesPage"
        }

        # Construct the download URL (typical pattern for MediathekView)
        $url32 = "https://download.mediathekview.de/stable/$version/MediathekView-$version-windows.exe"

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
