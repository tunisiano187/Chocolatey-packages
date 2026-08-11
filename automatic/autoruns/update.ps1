$ErrorActionPreference = 'Stop'
Import-Module chocolatey-AU

$liveExeUrl = 'https://live.sysinternals.com/autoruns.exe'
$zipUrl     = 'https://download.sysinternals.com/files/Autoruns.zip'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	. ..\..\scripts\Invoke-VirusTotalScan.ps1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$tmpExe = Join-Path $env:TEMP "autoruns_version_check.exe"
	Invoke-WebRequest -Uri $liveExeUrl -OutFile $tmpExe -UseBasicParsing
	$version = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($tmpExe).FileVersion.Trim()
	Remove-Item $tmpExe -Force -ErrorAction SilentlyContinue

	$Latest = @{ URL32 = $zipUrl; Version = $version }
	return $Latest
}

update -ChecksumFor 32
