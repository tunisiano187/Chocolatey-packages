$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://api.github.com/repos/mysteriumnetwork/mysterium-vpn-desktop/releases/latest'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      			= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 			= "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumtype\s*=\s*)('.*')" 		= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_GetLatest {
	$tags = Invoke-WebRequest $releases -UseBasicParsing | ConvertFrom-Json
	$url32 = ($tags[0].assets | Where-Object {$_.browser_download_url -match ".exe$"}).browser_download_url
	$version=$($url32).split('-')[-1].replace('.exe','')


	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32
