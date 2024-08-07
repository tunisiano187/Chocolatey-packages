﻿$ErrorActionPreference = 'Stop'
import-module au

$url32 = 'https://www.nirsoft.net/utils/chromehistoryview.zip'

Add-Type -AssemblyName System.IO.Compression.FileSystem


function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$File = "$($env:TEMP)\chocolatey\chromehistoryview.zip"
	$ExtractFolder = "$($env:TEMP)\chocolatey\chomehistoryview"
	if(Test-Path $ExtractFolder) {
		Remove-Item -Path $ExtractFolder -Recurse -Force
	}
	New-Item -Path $ExtractFolder -ItemType Directory
	Invoke-WebRequest -Uri $url32 -OutFile $File -UseBasicParsing
	Expand-Archive $File -DestinationPath $ExtractFolder

	$version=$(Get-Content $ExtractFolder\readme.txt | Where-Object {$_ -match ' Version'})[0].split(' ')[2]

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion
