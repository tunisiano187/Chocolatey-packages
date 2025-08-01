$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'https://www.opus-codec.org/downloads/'

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
	$urls = (( Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object  {$_.href -match 'opus/win'} | Where-Object {$_.href -match '-win'}).href
	$url32 = $urls | Where-Object {$_ -match 'win32'}
	$url64 = $urls | Where-Object {$_ -match 'win64'}
	$version = $url32.split('-')[-2]
	if($version -eq "0.2") {
		$version = "0.2.0.20221010"
	}

	return @{ 	URL32 = $url32
				URL64 = $url64
				Version = $version
	}
}

try {
    update
} catch {
    $ignore = "The request was aborted: Could not create SSL/TLS secure channel."
    if ($_ -match $ignore) { Write-Output $ignore; 'ignore' } else { throw $_ }
}
