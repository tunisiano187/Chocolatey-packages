$ErrorActionPreference = 'Stop'
import-module au

$release = "https://dexpot.de/index.php?id=thankyou"

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
	$page = Invoke-WebRequest -Uri "https://dexpot.de/?id=download" -UseBasicParsing
    $regexPattern = '<li>(\d+\.\d+\.\d+)\s+Build\s+(\d+)'
	$versionMatch = $page.Content | Select-String -Pattern $regexPattern -AllMatches
    $match = $versionMatch.Matches[0]
	$version = "$($match.Groups[1].Value).$($match.Groups[2].Value)"

	$Latest = @{ URL32 = $release; Version = $version }
    return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion
