$ErrorActionPreference = 'Stop'
import-module AU
Import-Module ..\..\scripts\au_extensions.psm1

$releases = 'http://vaemendis.net/ubooquity/static2/download'

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
	$url32 = 'https://stompsoftware.com/downloadfiles/albumstomp/SetupAlbumStompV2.exe'

	$pageContent = Invoke-WebRequest -Uri $releases -UseBasicParsing
	$versionPattern = 'Version\s+(\d+\.\d+\.\d+)'
	$versionMatch = [regex]::Match($pageContent, $versionPattern)

	$version=$versionMatch.Groups[1].Value

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32
