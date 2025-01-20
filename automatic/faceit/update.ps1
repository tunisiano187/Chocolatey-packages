$ErrorActionPreference = 'Stop'
import-module au
. ..\..\scripts\Get-FileVersion.ps1

$release = 'https://faceit-client.faceit-cdn.net/release/FACEIT-setup-latest.exe'

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
	$file=New-TemporaryFile
	$page = Invoke-WebRequest -Uri "https://faceit-client.faceit-cdn.net/release/RELEASES?id=FACEIT&localVersion=2.0.18&arch=amd64" -OutFile $file
	$page=get-Content -Path $file
	$version = (($page | Select-Object -Last 1).split(' ')[1]).split('-')[1]

	$Latest = @{ URL32 = $release; Version = $version }
	return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion