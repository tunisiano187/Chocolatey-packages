$ErrorActionPreference = 'Stop'
import-module au

$release = 'https://static.monosnap.com/windows/MonosnapSetup.exe'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$File = Join-Path $env:TEMP "MonosnapSetup.exe"
	Invoke-WebRequest -Uri $release -OutFile $File
	$version=(7z x $File -o$($env:temp)  | Where-Object {$_ -match 'FileVersion'} | Select-Object -Last 1).split(' ') | Select-Object -Last 1

	$Latest = @{ URL32 = $release; Version = $version }
	return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion
