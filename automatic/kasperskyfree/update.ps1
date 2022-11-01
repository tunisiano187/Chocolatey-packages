$ErrorActionPreference = 'Stop'

import-module au

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
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
	$releases="https://trial.s.kaspersky-labs.com/registered/w0wci3bxizuuge8wzc3j/"
	$release=(Invoke-WebRequest -uri $releases).Links
	$version=$release.href | foreach{$_.split('_')[-1].replace('/','') } | Sort-Object | Select-Object -Last 1
	$folder = "$releases$($release.href | Where-Object {$_ -match $version})"
	$url32 = "$folder$(((Invoke-WebRequest -Uri $folder).Links | Where-Object {$_.href -match "exe"}).href)"

	$File = "$($env:TEMP)\kav.exe"
	Invoke-WebRequest -Uri $url32 -OutFile $File
	$version=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion.trim()
	$copyright = (Get-Item($File)).VersionInfo.LegalCopyright
	$encoding = New-Object System.Text.UTF8Encoding($false)
	$NuspecPath = "$(Get-Location)\kasperskyfree.nuspec"
	$nuspec = Get-Content $NuspecPath -Encoding UTF8
	$nuspec = $nuspec -replace '<copyright>.*',"<copyright>$copyright</copyright>"
	$output = ($nuspec | Out-String) -replace '\r\n?',"`n"
	[System.IO.File]::WriteAllText("$NuspecPath", $output, $encoding);

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion
