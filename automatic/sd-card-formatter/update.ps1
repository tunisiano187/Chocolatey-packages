$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'https://www.sdcard.org/downloads/formatter/sd-memory-card-formatter-for-windows-download/'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_BeforeUpdate {
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $Latest.URL32
	$Latest.Checksum32 = $FileVersion.Checksum
	$Latest.ChecksumType32 = $FileVersion.checksumType
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$url32 = "https://www.sdcard.org$(((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object  {$_ -match 'Accept'} | Where-Object {$_.href -match '.zip'}).href.replace('./',''))"
	$url32 = [URI]::EscapeUriString($url32)
	$url = "https://www.sdcard.org/downloads/formatter/"
	$pageContent = Invoke-WebRequest -Uri $url -UseBasicParsing
	$versionPattern = 'SD Memory Card Formatter\s*(\d+\.\d+\.\d+)'
	$match = [regex]::Match($pageContent.Content, $versionPattern)
	$version = $match.Groups[1].Value
	if($version -eq '5.0.3' ) {
		$version = '5.0.3.2025011901'
	}

	return @{ URL32 = $url32
		Version = $version
	}
}

update -ChecksumFor none -NoCheckChocoVersion
