$ErrorActionPreference = 'Stop'
import-module au

$release = "https://browser.yandex.com/download?banerid=6500000000&statpromo=true&partner_id=default"

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')"            = "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')"       = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType\s*=\s*)('.*')"   = "`$1'$($Latest.ChecksumType32)'"
        }
     }
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$url32 = (Get-RedirectedUrl -url $release).split('?')[0] -replace "/lite/","/"

    $ver = ($url32.Split("/") | Where-Object {$_ -match "_"}).split('_')
	$version = "$($ver[0]).$($ver[1]).$($ver[2]).$($ver[3])"

	$Latest = @{ URL32 = $url32; Version = $version }
    return $Latest
}

try {
	update -ChecksumFor 32
} catch {
	$ignore = '403 (Forbidden)'
	if ($_ -match $ignore) { Write-Output $_; 'ignore' } else { throw $_ }
}