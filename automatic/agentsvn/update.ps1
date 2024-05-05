$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://www.zeusedit.com/agent/download.html'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url32\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
            "(^[$]checksum32\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
            "(^[$]url64\s*=\s*)('.*')"        = "`$1'$($Latest.URL64)'"
            "(^[$]checksum64\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
    $page=Invoke-WebRequest -uri $releases
    $version = $page.Content | Where-Object { $_ -match 'Agent SVN [0-9\.]+'}
    $version = $Matches[0].Split(' ')[-1]
    $exist = $page.Content | Where-Object { $_ -match 'asvn32-v[0-9]+'}
    if($Matches[0]) {
        $url32 = "https://www.zeusedit.com/agent/bin/$($Matches[0]).zip"
    } else {
        $version = "0.0"
    }
    $url64 = $url32 -replace "asvn32","asvn64"

    return @{ URL32 = $url32; URL64 = $url64; Version = $version }
}

try {
	update
} catch {
	$ignore = '403 (Forbidden)'
	if ($_ -match $ignore) { Write-Output $_; 'ignore' } else { throw $_ }
}