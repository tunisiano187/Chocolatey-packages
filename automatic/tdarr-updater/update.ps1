$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://docs.tdarr.io/docs/installation/windows-linux-macos'

function global:au_SearchReplace {
	@{
		"legal\VERIFICATION.txt"      = @{
			"(?i)(x86:).*"      		= "`${1} $($Latest.URL32)"
			"(?i)(checksum:).*" 		= "`${1} $($Latest.Checksum32)"
			"(?i)(checksum Type:).*" 	= "`${1} $($Latest.ChecksumType32)"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$url32 		= (((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match 'win32_x64/Tdarr_Updater.zip'}).href)
	$version 	= Get-Version $url32
	$File		= "tools\Tdarr_Updater.zip"
	Invoke-WebRequest -Uri $url32 -OutFile $File
	$checksum	= (Get-FileHash -Path $File -Algorithm $env:ChocolateyChecksumType).Hash

	$Latest = @{ URL32 = $url32; Version = $version; Checksum32 = $checksum; ChecksumType32 = $env:ChocolateyChecksumType }
	return $Latest
}

update -ChecksumFor none