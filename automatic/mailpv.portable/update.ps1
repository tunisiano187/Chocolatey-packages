$ErrorActionPreference = 'Stop'
import-module au

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
	$url32 = "https://www.nirsoft.net/toolsdownload/mailpv.zip"
	$strHeader = @{
		"referer"="https://www.nirsoft.net/utils/mailpv.html"
	}
	Invoke-WebRequest -Uri $url32 -OutFile "tools/mailpv.zip" -UserAgent $(Get-UserAgent) -Headers $strHeader
	$checksum = Get-FileHash -Path "tools/mailpv.zip" -Algorithm $env:ChocolateyChecksumType
	$pageContent = Invoke-WebRequest -Uri "https://www.nirsoft.net/utils/mailpv.html"
	$regexPattern = 'PassView v(\d+(\.\d+)*)'
	$versionMatch = $pageContent.Content | Select-String -Pattern $regexPattern -AllMatches
	$version = $versionMatch.Matches[0].Groups[1].Value
	Update-Metadata -key "copyright" -value "© $(Get-Date -Format "yyyy") NirSoft"

	$Latest = @{ URL32 = $url32; Checksum32 = $checksum; ChecksumType32 = $env:ChocolateyChecksumType ; Version = $version }
	return $Latest
}

update -NoCheckUrl -ChecksumFor none
