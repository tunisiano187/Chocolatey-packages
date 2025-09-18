import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$releases = 'https://benchmarks.ul.com/systeminfo'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]Url(32)?\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum(32)?\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType(32)?\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$pageContent = Invoke-WebRequest -Uri $releases -UseBasicParsing
	$regexPattern = 'SystemInfo \s*(\d+(\.\d+)*)</h2>'
	$versionMatch = $pageContent.Content | Select-String -Pattern $regexPattern -AllMatches

	$version = $versionMatch.Matches[0].Groups[1].Value
	$url32 = get-redirectedUrl "https://benchmarks.ul.com/downloads/systeminfo/latest"

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update
