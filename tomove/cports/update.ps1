$ErrorActionPreference = 'Stop'
import-module au

Add-Type -AssemblyName System.IO.Compression.FileSystem
function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
			"(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
			"(^[$]checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$url32 = 'https://www.nirsoft.net/utils/cports.zip'
	$url64 = 'https://www.nirsoft.net/utils/cports-x64.zip'
	$tmpPath = "$($env:TEMP)\chocolatey\chocolatey\cports\"
	New-Item -Path $tmpPath -ItemType Directory
	$ZipFile = Join-Path $tmpPath "cports.zip"
	Invoke-WebRequest -Uri $url32 -OutFile $ZipFile -UseBasicParsing
	Expand-Archive $ZipFile -DestinationPath $tmpPath

	$version=$(Get-Content $tmpPath\readme.txt | Where-Object {$_ -match '\* Version'})[0].split(' ')[-1].Replace(':','').Trim()

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

update