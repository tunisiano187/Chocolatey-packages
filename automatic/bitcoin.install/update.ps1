$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://github.com/bitcoin/bitcoin/releases'

if ($MyInvocation.InvocationName -ne '.') {
    function global:au_SearchReplace {
        @{
            'tools/chocolateyInstall.ps1' = @{
                "(^[$]url64\s*=\s*)('.*')"            = "`$1'$($Latest.URL64)'"
                "(^[$]checksum64\s*=\s*)('.*')"       = "`$1'$($Latest.Checksum64)'"
                "(^[$]checksumType64\s*=\s*)('.*')"       = "`$1'$($Latest.ChecksumType64)'"
            }
        }
    }
}

function global:au_GetLatest {
    Write-Verbose 'Get version'
    $version = $(((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match ".zip"} | Select-Object -First 1).href).split('/')[-1].replace('.zip', '').replace('v','')
    $realversion = $version.replace('rc','-rc');
    $folder = "https://bitcoincore.org/bin/$(((Invoke-WebRequest -Uri 'https://bitcoincore.org/bin/' -UseBasicParsing).Links | Where-Object {$_.href -match $version}| Select-Object -Last 1).href)"

	Write-Verbose 'Get files'
	$file = $(((Invoke-WebRequest -Uri $folder -UseBasicParsing).Links | Where-Object {$_.href -match ".exe"}).href)
    $url64 = "$folder$file"

    return @{ URL64 = $url64; Version = $realversion }
}

update -ChecksumFor 64
