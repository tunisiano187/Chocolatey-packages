$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'https://www.simplysup.com/tremover/download_full.html'

function global:au_SearchReplace {
	@{
		"legal\VERIFICATION.txt" = @{
			"(url32+:).*"  			= "`${1} $($Latest.URL32)"
			"(checksum32+:).*" 		= "`${1} $($Latest.Checksum32)"
			"(checksumtype+:).*" 		= "`${1} $($Latest.ChecksumType32)"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$page = Invoke-WebRequest -Uri $releases -UseBasicParsing
	$url = $page.Links.href | Where-Object {$_ -match "exe$"} | Select-Object -First 1
	$File = Join-Path $PSScriptRoot "tools\trjsetup.exe"

	Invoke-WebRequest -Uri $url -OutFile $File -UseBasicParsing
	$version=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion.Trim()

	$Latest = @{ URL32 = $url; Version = $version }
	return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion
