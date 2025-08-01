$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

function global:au_SearchReplace {
	@{
		"legal\VERIFICATION.txt"      = @{
			"(?i)(x86:).*"        				= "`${1} $($Latest.URL32)"
			"(?i)(checksum:).*" 				= "`${1} $($Latest.Checksum32)"
			"(?i)(x64:).*"        				= "`${1} $($Latest.URL64)"
			"(?i)(checksum64:).*" 				= "`${1} $($Latest.Checksum64)"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$url32 = "https://www.nirsoft.net/utils/sysexp.zip"
	$url64 = "https://www.nirsoft.net/utils/soundvolumeview-x64.zip"
	Invoke-WebRequest -Uri $url32 -OutFile "tools/sysexp.zip" -UseBasicParsing
	Invoke-WebRequest -Uri $url64 -OutFile "tools/sysexp-x64.zip" -UseBasicParsing
	$pageContent = Invoke-WebRequest -Uri "https://www.nirsoft.net/utils/sysexp.html"
	$regexPattern = 'SysExporter v(\d+(\.\d+)*)'
	$versionMatch = $pageContent.Content | Select-String -Pattern $regexPattern -AllMatches
	$version = $versionMatch.Matches[0].Groups[1].Value
	Update-Metadata -key "copyright" -value "© $(Get-Date -Format "yyyy") NirSoft"

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

update -NoCheckChocoVersion
