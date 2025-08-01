$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

function global:au_SearchReplace {
	@{
		"legal\VERIFICATION.txt"      = @{
			"(?i)(x86:).*"        				= "`${1} $($Latest.URL32)"
			"(?i)(checksum:).*" 				= "`${1} $($Latest.Checksum32)"
			"(?i)(checksum type:).*" 			= "`${1} $($Latest.ChecksumType32)"
			"(?i)(x64:).*"        				= "`${1} $($Latest.URL64)"
			"(?i)(checksum64:).*" 				= "`${1} $($Latest.Checksum64)"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$url32 = "https://www.nirsoft.net/utils/soundvolumeview.zip"
	$url64 = "https://www.nirsoft.net/utils/soundvolumeview-x64.zip"
	Invoke-WebRequest -Uri $url32 -OutFile "tools/soundvolumeview.zip" -UseBasicParsing
	Invoke-WebRequest -Uri $url64 -OutFile "tools/soundvolumeview-x64.zip" -UseBasicParsing
	$Checksum32 = (Get-FileHash -Path "tools/soundvolumeview.zip" -Algorithm $env:ChocolateyChecksumType).Hash
	$Checksum64 = (Get-FileHash -Path "tools/soundvolumeview-x64.zip" -Algorithm $env:ChocolateyChecksumType).Hash
	$pageContent = Invoke-WebRequest -Uri "https://www.nirsoft.net/utils/sound_volume_view.html"
	$regexPattern = 'SoundVolumeView v(\d+(\.\d+)*)'
	$versionMatch = $pageContent.Content | Select-String -Pattern $regexPattern -AllMatches
	$version = $versionMatch.Matches[0].Groups[1].Value
	Update-Metadata -key "copyright" -value "© $(Get-Date -Format "yyyy") NirSoft"

	$Latest = @{ URL32 = $url32; Checksum32 = $Checksum32; ChecksumType32 = $env:ChocolateyChecksumType; URL64 = $url64; Checksum64 = $Checksum64; ChecksumType64 = $env:ChocolateyChecksumType; Version = $version }
	return $Latest
}

update -NoCheckChocoVersion -ChecksumFor none
