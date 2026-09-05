$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = "https://wampserver.aviatechno.net/"

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
     }
}

function global:au_AfterUpdate($Package) {
	Import-Module ..\..\scripts\au_extensions.psm1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
    $url32 = "$($releases)$((((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match 'exe'}).href) | Where-Object {$_ -match 'x64'} | Select-Object -First 1)"
    if ($url32 -match "(\d+\.\d+\.\d+)_x64\.exe") {
        $version = $matches[1]
    }
    if($version -eq '3.4.0') {
        # wampserver.aviatechno.net doesn't bump the exe's version-in-filename on every silent
        # refresh, and the single-package push handler in .appveyor.yml doesn't commit back to
        # git (same root cause documented for netbeans/cports/projectlibre.install) -- so the
        # nuspec stays at 0.0 forever and a bare version-string comparison always looks "new"
        # even when nothing actually changed, hitting 409 Conflict every run. Compare the
        # freshly-downloaded checksum against what's already committed in chocolateyInstall.ps1
        # instead -- ground truth for "did the exe actually change" -- and only bump when it
        # genuinely has, using the exe's own Last-Modified date rather than "today" so repeated
        # checks before a successful commit lands don't each mint a further new version. Same
        # technique already used by windjview.
        . ..\..\scripts\Get-FileVersion.ps1
        $fileVersion = Get-FileVersion $url32 -checksumType 'sha256'
        $installContent = Get-Content "$PSScriptRoot\tools\chocolateyInstall.ps1" -Raw
        $current_checksum = [regex]::Match($installContent, "\`$checksum\s*=\s*'([a-fA-F0-9]+)'").Groups[1].Value
        if ($current_checksum -and $current_checksum -ne $fileVersion.Checksum) {
            try {
                $lastModified = (Invoke-WebRequest -Uri $url32 -Method Head -UseBasicParsing).Headers['Last-Modified']
                $dateStamp = ([datetime]::Parse($lastModified)).ToString('yyyyMMdd')
            } catch {
                $dateStamp = Get-Date -Format 'yyyyMMdd'
            }
            $version = "$version.$dateStamp"
        }
    }

	$Latest = @{ URL32 = $url32; Version = $version }
    return $Latest
}

update -ChecksumFor 32
