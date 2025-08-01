$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$domain = 'https://www.medo64.com'
$releases = 'https://www.medo64.com/vhdattach/'

function global:au_SearchReplace {
	@{
		"legal\VERIFICATION.txt" = @{
			"(url32+:).*"  			= "`${1} $($Latest.URL32)"
			"(checksum32+:).*" 		= "`${1} $($Latest.Checksum32)"
			"(checksumtype+:).*" 	= "`${1} $($Latest.ChecksumType32)"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$page = Invoke-WebRequest -Uri $releases -UseBasicParsing

	$url32 = "$domain$(($page.Links | Where-Object {$_.href -match '.exe$'}).href)"
	. ..\..\scripts\Get-FileVersion.ps1
	$FileInfos = Get-FileVersion -url $url32 -keep
	Move-Item -Path $FileInfos.TempFile -Destination "tools\$($url32.Split("/")[-1])"

	$Latest = @{ URL32 = $url32; Version = $FileInfos.Version; Checksum32 = $FileInfos.CHECKSUM; ChecksumType32 = $FileInfos.ChecksumType }
	return $Latest
}

update -ChecksumFor none -NoCheckChocoVersion
