$ErrorActionPreference = 'Stop'
import-module au

$release = 'https://appdownload.deepl.com/windows/0install/DeepLSetup.exe'

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
	$xml='https://appdownload.deepl.com/windows/0install/deepl.xml'
	$File = Join-Path $env:TEMP "DeepLSetup.xml"
	Invoke-WebRequest -Uri $xml -OutFile $File
	[xml]$ver=Get-Content($File)

	$version=($ver.interface.group.group.group.implementation | Select-Object -Last 1).version

	$Latest = @{ URL32 = $release; Version = $version }
	return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion
