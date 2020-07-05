import-module au

$releases = "http://wampserver.aviatechno.net/"

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(^[$]url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
     }
}

function global:au_GetLatest {
	$url32 = "$($releases)$((((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match 'exe'}).href)[0])"
	$url64 = $url32.replace('x86','x64')
	
	$version = $url32.split('/').split('_')[-2].replace('wampserver','')
	
	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
    return $Latest
}

update -NoCheckChocoVersion
Test-Package
