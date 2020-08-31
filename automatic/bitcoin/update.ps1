$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://github.com/bitcoin/bitcoin/releases'

if ($MyInvocation.InvocationName -ne '.') {
    function global:au_SearchReplace {
        @{
            "$($Latest.PackageName).nuspec" = @{
                "(\<dependency .+?`"$($Latest.PackageName).install`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
            }
        }
    }
}

function global:au_GetLatest {
    Write-Verbose 'Get version'
    $version = $(((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match ".zip"} | Select-Object -First 1).href).split('/')[-1].replace('.zip', '').replace('v','')
	Write-Verbose 'Get files'
	$url64 = $("https://bitcoincore.org/bin/bitcoin-core-0.20.1/bitcoin-0.20.1-win64-setup.exe").replace('0.20.1',$version)

    return @{ URL64 = $url64; Version = $version }
}

update -ChecksumFor none -NoCheckChocoVersion