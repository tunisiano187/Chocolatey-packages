$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://yacy.net/download_installation/'

function global:au_SearchReplace {
	@{
		"tools\VERIFICATION.txt" = @{
			"(^Version\s+:).*"  = "`${1} $($Latest.Version)"
			"(^URL\s+:).*"      = "`${1} $($Latest.URL32)"
			"(^Checksum\s+:).*" = "`${1} $($Latest.Checksum32)"
		 }
	}
}

function global:au_GetLatest {
	Write-Output 'Check Folder'
	$url32 = ($((((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links)) | Where-Object {$_.href -match '.exe'}) | Select-Object -First 1).href
	Write-Output 'Checking version'
	$version=$($url32).split('v')[-1].split('_')[0]
	
	
	
	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

function global:au_BeforeUpdate() {
	Write-host "Downloading yacy $($Latest.Version) installer file"
	Get-RemoteFiles -Purge -NoSuffix
 }
 
 update -ChecksumFor none
