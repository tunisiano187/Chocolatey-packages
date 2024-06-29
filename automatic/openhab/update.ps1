$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://www.openhab.org/download/'

function global:au_SearchReplace {
	@{
		"legal\VERIFICATION.txt"      = @{
			"(?i)(x86:).*"        				= "`${1} $($Latest.URL32)"
			"(?i)(checksum:).*" 				= "`${1} $($Latest.Checksum32)"
			"(?i)(checksumtype:).*" 			= "`${1} $($Latest.ChecksumType32)"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$page = Invoke-WebRequest -Uri $releases -UseBasicParsing
	$url32 = ($page.Links | Where-Object {$_.href -match ".zip$"}).href
	$version = (Get-Version $url32).Version
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $url32 -keep
	Move-Item -Path $FileVersion.TempFile -Destination "toolsdir\$($url32.Split('/')[-1])"

	Update-Metadata -key "copyright" -value "© $(Get-Date -Format "yyyy") NirSoft"

	$Latest = @{ URL32 = $url32; Checksum32 = $FileVersion.CHECKSUM; ChecksumType32 = $FileVersion.ChecksumType; Version = $version }
	return $Latest
}

update -NoCheckUrl -ChecksumFor none -NoCheckChocoVersion
