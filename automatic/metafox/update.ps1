$ErrorActionPreference = 'Stop'
import-module au

function global:au_SearchReplace {
	@{
		'.\legal\VERIFICATION.txt' = @{
			"(?i)(\s+url:).*"                   = "`${1} $($Latest.URL32)"
			"(?i)(Get-RemoteChecksum).*"        = "`${1} $($Latest.URL32)"
			"(?i)(\s+checksum:).*"	            = "`${1} $($Latest.Checksum32)"
			"(?i)(\s+unzipped:).*"              = "`${1} $($Latest.Unzipped)"
		}
	}
}

function global:au_BeforeUpdate {
	. ..\..\scripts\Get-FileVersion.ps1 -keep
	$FileVersion = Get-FileVersion $Latest.URL32 -keep
	Expand-Archive -Path $FileVersion.TempFile -DestinationPath "tools/"
	Move-Item -Path $Latest.TempFile -Destination 'tools\MetaFox.exe'
	$Latest.Unzipped = Get-FileHash -Path 'tools\MetaFox.exe' -Algorithm $FileVersion.checksumType
	$Latest.Checksum32 = $FileVersion.Checksum
	$Latest.ChecksumType32 = $FileVersion.checksumType
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$releases="https://codecpack.co/download/MetaFox.html"
	$page = Invoke-WebRequest -Uri $releases -UseBasicParsing
	$regexPattern = 'MetaFox (\d+(\.\d+)*)'
	$versionMatch = $page.Content | Select-String -Pattern $regexPattern -AllMatches
	$version = $versionMatch.Matches[0].Groups[1].Value
	$url = ($page.Links | Where-Object {$_.title -match 'Download'}).href

	$Latest = @{ URL32 = $url; Version = $Version }
	return $Latest
}

update -ChecksumFor none
