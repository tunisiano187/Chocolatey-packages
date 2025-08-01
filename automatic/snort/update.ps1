$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = "https://www.snort.org/downloads"

function global:au_SearchReplace {
    @{
        "legal\VERIFICATION.txt"      = @{
			"(?i)(x86:).*"        				= "`${1} $($Latest.URL32)"
			"(?i)(checksum:).*" 				= "`${1} $($Latest.Checksum32)"
			"(?i)(checksumtype:).*" 			= "`${1} $($Latest.ChecksumType32)"
		}
     }
}

function global:au_BeforeUpdate {
    . ..\..\scripts\Get-FileVersion.ps1
    $FileVersion = Get-FileVersion -url $Latest.URL32 -keep
    Move-Item -Path $FileVersion.TempFile -Destination "tools\Snort_Installer.exe"
    $Latest.Checksum32      = $FileVersion.Checksum
    $Latest.ChecksumType32  = $FileVersion.ChecksumType
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -Uri $releases -UserAgent "Chocolatey cli"
    $url32 = "https://www.snort.org$(($page.Links | Where-Object {$_ -match 'installer'}).href)"

	$version = (Get-Version $url32.Replace('_','.')).Version

	$Latest = @{ URL32 = $url32; Version = $version }
    return $Latest
}

update -ChecksumFor none -NoCheckUrl -NoCheckChocoVersion
