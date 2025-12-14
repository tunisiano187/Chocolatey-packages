$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$url32 = 'https://www.nirsoft.net/utils/wakemeonlan.zip'
$url64 = 'https://www.nirsoft.net/utils/wakemeonlan-x64.zip'

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
	Import-Module ..\..\scripts\au_extensions.psm1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$File = "./usblogview.zip"
	Invoke-WebRequest -Uri $url32 -OutFile $File -UseBasicParsing
	Expand-Archive $File -DestinationPath .\wol

	$version=$(Get-Content .\wol\readme.txt | Where-Object {$_ -match 'WakeMeOnLan'})[0].split(' ')[-1].Replace('v','')
	Remove-Item -Recurse .\wol -Force
	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

update -NoCheckChocoVersion
