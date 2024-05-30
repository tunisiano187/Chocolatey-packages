$ErrorActionPreference = 'Stop'
import-module au

$release = 'https://qatgqujbd2.execute-api.us-west-2.amazonaws.com/prod/getCurrentVersion'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumtype\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}



function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$json = Invoke-RestMethod -Method Get -Uri $release
	$url = $json.Native.installer_url
	$version=$json.Native.version
	$File = Join-Path $env:TEMP $($url -split "/" | Select-Object -Last 1)
	Invoke-WebRequest -Uri $url -OutFile $File
	$checksum = (Get-FileHash -Path $File -Algorithm $env:ChocolateyChecksumType).Hash

	$Latest = @{ URL32 = $url; Version = $version; Checksum32 = $checksum; ChecksumType32 = $env:ChocolateyChecksumType }
	return $Latest
}

update -ChecksumFor none -NoCheckChocoVersion
