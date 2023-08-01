$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://files.lhmouse.com/nano-win/'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      			= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 			= "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumtype\s*=\s*)('.*')" 		= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	Write-Verbose 'Get files'
	$filename = (Invoke-WebRequest -Uri $releases -UseBasicParsing).Links.href | Where-Object {$_ -match '\.7z'} | Sort-Object | Select-Object -Last 1
	Write-Verbose 'Checking version'
	$fileversion_regex = '(?<=v)[0-9\.\-]+[0-9](?!=\[0-9])'
	$version = ($filename | Select-String -Pattern $fileversion_regex).Matches.Value -replace '-','.'

	$url32 = $releases + $filename
	Write-Verbose "Version : $version"

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion
