$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

function global:au_SearchReplace {
	@{
		"legal\VERIFICATION.txt"      = @{
			"(?i)(x86:).*"        				= "`${1} $($Latest.URL32)"
			"(?i)(checksum:).*" 				= "`${1} $($Latest.Checksum32)"
			"(?i)(checksumtype:).*" 			= "`${1} $($Latest.ChecksumType32)"
			"(?i)(x64:).*"        				= "`${1} $($Latest.URL64)"
			"(?i)(checksum64:).*" 				= "`${1} $($Latest.Checksum64)"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$url32 = "https://www.nirsoft.net/utils/ofview.zip"
	$strHeader = @{
		"referer"="https://www.nirsoft.net/utils/opened_files_view.html"
	}
	Invoke-WebRequest -Uri $url32 -OutFile "tools/ofview.zip" -UserAgent $([Microsoft.PowerShell.Commands.PSUserAgent]::Chrome) -Headers $strHeader
	$checksum = (Get-FileHash -Path "tools/ofview.zip" -Algorithm $env:ChocolateyChecksumType).Hash
	$url64 = "https://www.nirsoft.net/utils/ofview-x64.zip"
	Invoke-WebRequest -Uri $url64 -OutFile "tools/ofview-x64.zip" -UserAgent $([Microsoft.PowerShell.Commands.PSUserAgent]::Chrome) -Headers $strHeader
	$checksum64 = (Get-FileHash -Path "tools/ofview-x64.zip" -Algorithm $env:ChocolateyChecksumType).Hash
	$pageContent = Invoke-WebRequest -Uri "https://www.nirsoft.net/utils/opened_files_view.html"
	$regexPattern = 'OpenedFilesView v(\d+(\.\d+)*)'
	$versionMatch = $pageContent.Content | Select-String -Pattern $regexPattern -AllMatches
	$version = $versionMatch.Matches[0].Groups[1].Value
	Update-Metadata -key "copyright" -value "© $(Get-Date -Format "yyyy") NirSoft"

	$Latest = @{ URL32 = $url32; Checksum32 = $checksum; ChecksumType32 = $env:ChocolateyChecksumType; URL64 = $url64; Checksum64 = $checksum64; ChecksumType64 = $env:ChocolateyChecksumType; Version = $version }
	return $Latest
}

update -NoCheckUrl -ChecksumFor none -NoCheckChocoVersion
