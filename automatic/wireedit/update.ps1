$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = "https://omnipacket.com/downloads"

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
    . ../../scripts/Get-UserAgent.ps1
	$url32="https://omnipacket.com/$(((Invoke-WebRequest -Uri $releases -UserAgent "$(Get-UserAgent)" -UseBasicParsing).Links | Where-Object {$_ -match '.msi'} | Where-Object {$_ -match 'WireEdit'}).href)"

    $version = $url32.Split("-")[-1].replace('.msi','')

	$Latest = @{ URL32 = $url32; Version = $version }

    return $Latest
}

try {
    update -ChecksumFor 32
} catch {
    $ignore = "Unable to connect to the remote server"
    if ($_ -match $ignore) { Write-Output $ignore; 'ignore' } else { throw $_ }
}
