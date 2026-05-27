$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$versionsUrl = 'https://www.teamspeak.com/versions/server.json'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url32\s*=\s*)('.*')"      	= "`$1'$($Latest.URL32)'"
			"(^[$]checksum32\s*=\s*)('.*')" 	= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
			"(^[$]url64\s*=\s*)('.*')"      	= "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" 	= "`$1'$($Latest.Checksum64)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	. ..\..\scripts\Invoke-VirusTotalScan.ps1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$headers = @{ 'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36' }
	$json = Invoke-WebRequest -Uri $versionsUrl -UseBasicParsing -Headers $headers | ConvertFrom-Json

	$win32 = $json.windows.x86
	$win64 = $json.windows.x86_64

	return @{
		Version        = $win32.version
		URL32          = $win32.mirrors.'teamspeak.com'
		URL64          = $win64.mirrors.'teamspeak.com'
		Checksum32     = $win32.checksum.ToUpper()
		ChecksumType32 = 'sha256'
		Checksum64     = $win64.checksum.ToUpper()
		ChecksumType64 = 'sha256'
	}
}

update -ChecksumFor none
