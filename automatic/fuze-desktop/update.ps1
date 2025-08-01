import-module chocolatey-AU

$releases = 'https://api.fuze.com/citadel/v1/applications/fuzeapp/windows/versions/latest/download/perMachineInstaller'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url(32)?\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum(32)?\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType(32)?\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$url = Get-RedirectedUrl $releases
	$version = (Get-Version $url).Version

	$Latest = @{ URL32 = $url; Version = $version }
	return $Latest
}

update -NoCheckChocoVersion
