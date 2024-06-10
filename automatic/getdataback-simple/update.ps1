$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://www.runtime.org/gdbprosetup.exe'

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
	$File = Join-Path $env:TEMP "chocolatey\gdbprosetup.exe"
	Invoke-WebRequest -Uri $releases -OutFile $File
	$version=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion.Trim()

	$Latest = @{ URL32 = $releases; Version = $version }
	return $Latest
}

try {
	update -ChecksumFor 32
} catch {
	$ignore = "Response status code does not indicate success"
	if ($_ -match $ignore) { Write-Output $ignore; 'ignore' } else { throw $_ }
}