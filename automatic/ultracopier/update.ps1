$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = "https://ultracopier.herman-brule.com/"

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(^[$]url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
            "(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
     }
}

function global:au_AfterUpdate($Package) {
	Import-Module ..\..\scripts\au_extensions.psm1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

	$re  = "-x86-"
	# The download page can list more than one release at once (e.g. a current and a previous
	# version side by side), so more than one split segment can match -x86-. Confirmed live:
	# $url32 silently became a 2-element array, and .Replace() below applied itself to each
	# element via PowerShell's array member enumeration, turning $url64 into a 2-element array
	# too -- which then space-joins into one string when AU validates it as a URI, producing
	# "URL syntax is invalid: <url1> <url2>". Take every match, parse its version out, and pick
	# the highest one explicitly so $url32 is always a single string.
	$matches32 = @($download_page.Content.Split('"') | Where-Object {$_ -match $re})

	$candidates = $matches32 | ForEach-Object {
		$versionToken = ($_.Split('-') | Where-Object {$_ -match '\..\.'} | Where-Object {$_ -notmatch "ultra"} | Select-Object -Last 1)
		[PSCustomObject]@{ Url = $_; Version = $versionToken; Parsed = [version]($versionToken -replace '[^\d.]', '') }
	}
	$latest = $candidates | Sort-Object Parsed -Descending | Select-Object -First 1

	$url32 = $latest.Url
	$version = $latest.Version
	$url64 = $url32.Replace('x86','x86_64')

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
    return $Latest
}

update
