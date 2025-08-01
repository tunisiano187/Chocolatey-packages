$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$url32 = 'https://s3-us-west-2.amazonaws.com/packetstream-releases/latest/PacketStream.exe'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumtype\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$pageContent = Invoke-WebRequest -Uri "https://packetstream.software.informer.com/" -UseBasicParsing
	$regexPattern = 'PacketStream \s*(\d+(\.\d+)*)'
	$versionMatch = $pageContent.Content | Select-String -Pattern $regexPattern -AllMatches

	$version = $versionMatch.Matches[0].Groups[1].Value

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32
