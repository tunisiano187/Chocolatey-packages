$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'https://www.netdrive.net/download/windows/'

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
	$page = Invoke-WebRequest -Uri $releases -UseBasicParsing

	$url = ($page.Links | Where-Object {$_ -match ".exe"} | Select-Object -First 1).href.replace('.exe','.msi').replace('_Setup','')
	$version=$url.split('/')[-1].split('v|-')[-1].replace('.msi','')
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $url

	$Latest = @{ URL32 = $url; Version = $version; Checksum32 = $FileVersion.CHECKSUM; ChecksumType32 = $FileVersion.ChecksumType }
	return $Latest
}

update -ChecksumFor none -NoCheckChocoVersion
