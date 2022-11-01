$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://github.com/bitcoin/bitcoin/releases/latest'
$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 2

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

function global:au_BeforeUpdate {
	Import-Module VirusTotalAnalyzer -NoClobber -Force
	New-VirusScan -ApiKey $env:VT_APIKEY -Url $Latest.URL64
	Start-Sleep -Seconds 60
	$vt = (Get-VirusScan -ApiKey $env:VT_APIKEY -Url $Latest.URL64).data.attributes.reputation
	if ( $vt -gt 5 ) {
	  Write-Error "Ignoring $($Latest.PackageName) package due to virus total results - $vt positives"
	  return 'ignore'
	}
}

function global:au_GetLatest {
    Write-Verbose 'Get files'
	$tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo -Latest

    Write-Verbose 'Get version'
    [version]$version = $tags.name.Split(' ')[-1]
    $folder = "https://bitcoincore.org/bin/$(((Invoke-WebRequest -Uri 'https://bitcoincore.org/bin/' -UseBasicParsing).Links | Where-Object {$_.href -match $version}| Select-Object -Last 1).href)"

	Write-Verbose 'Get files'
	$file = $(((Invoke-WebRequest -Uri $folder -UseBasicParsing).Links | Where-Object {$_.href -match ".exe"}).href)
    $url64 = "$folder$file"

    return @{ URL64 = $url64; Version = $version }
}

update -ChecksumFor 64
