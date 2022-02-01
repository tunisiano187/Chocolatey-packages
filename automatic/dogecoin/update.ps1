$ErrorActionPreference = 'Stop'
import-module au

$releases = "https://github.com/dogecoin/dogecoin/releases"

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]version\s*=\s*)('.*')"      = "`$1'$($Latest.Version)'"
        }
     }
}

function global:au_GetLatest {
	$version = (((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match '/tag/v'} | Select-Object -First 1).href).split('v')[-1]

	$Latest = @{ Version = $version }
    return $Latest
}

update -ChecksumFor none
