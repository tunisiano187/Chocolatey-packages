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

function global:au_BeforeUpdate {
	Import-Module VirusTotalAnalyzer -NoClobber -Force
	New-VirusScan -ApiKey $env:VT_APIKEY -Url $Latest.URL32
	Start-Sleep -Seconds 60
	$vt = (Get-VirusScan -ApiKey $env:VT_APIKEY -Url $Latest.URL32).data.attributes.reputation
	if ( $vt -gt 5 ) {
	  Write-Error "Ignoring $($Latest.PackageName) package due to virus total results - $vt positives"
	  return 'ignore'
	}
}

function global:au_GetLatest {
	$File = Join-Path $env:TEMP "dexpot.exe"
	$url32 = "https://dexpot.de/$($((Invoke-WebRequest -Uri $release -UseBasicParsing).Links | Where-Object {$_ -match 'exe'}).outerHTML.split('"')[1])"
	Invoke-WebRequest -Uri $url32 -OutFile $File
	$version=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion
	if($version -eq "1.6.14") { $version="1.6.14.1" } #Solve previously rejected

	$Latest = @{ URL32 = $url32; Version = $version }
    return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion
