$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'https://wordweb.info/free/'

function global:au_SearchReplace {
	@{
		"legal\VERIFICATION.txt"      = @{
			"(?i)(link32:).*"        			= "`${1} $($Latest.URL32)"
			"(?i)(checksum32:).*" 				= "`${1} $($Latest.Checksum32)"
			"(?i)(checksumtype:).*" 			= "`${1} $($Latest.ChecksumType32)"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$page = Invoke-WebRequest -Uri $releases -UseBasicParsing
	$regexPattern = 'WordWeb (\d+(\.\d+)*)'
	$versionMatch = $page.Content | Select-String -Pattern $regexPattern -AllMatches
	$version = $versionMatch.Matches[0].Groups[1].Value
	$url32 = ($page.Links | Where-Object {$_.href -match ".exe$"}).href
	$file = "tools/$($url32.split("/")[-1])"
	Invoke-WebRequest -Uri $url32 -OutFile $file -UseBasicParsing
	$checksum = (Get-FileHash -Path $file -Algorithm $env:ChocolateyChecksumType).Hash

	$Latest = @{ URL32 = $url32; Version = $version; Checksum32 = $checksum; ChecksumType32 = $env:ChocolateyChecksumType }
	return $Latest
}

update -ChecksumFor none -NoCheckChocoVersion
