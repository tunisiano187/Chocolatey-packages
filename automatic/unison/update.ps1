$ErrorActionPreference = 'Stop'
import-module au

$releases = "https://github.com/bcpierce00/unison/releases"

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
     }
}

function global:au_GetLatest {
	$url32 = "https://github.com$((((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where {$_ -match 'windows'} | Where-Object {$_ -match '.zip'}).href)[0])"

	$version = $url32.split('/')[-2].replace('v','').Replace('_','-')

    $Latest = @{ URL32 = $url32; Version = $version }
    return $Latest
}

update -ChecksumFor 32
