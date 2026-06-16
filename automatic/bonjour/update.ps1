$ErrorActionPreference = 'Continue';
import-module chocolatey-AU

$releases = 'https://www.apple.com/itunes/download/win'
$install_fname = 'bonjour.exe'
$exeFile = Join-Path $env:TEMP $install_fname

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
			"(^[$]url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
			"(^[$]checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_BeforeUpdate($Package) {
	$Latest.ChecksumType32 = $Latest.ChecksumType64 = "SHA256"
	if (Test-Path $exeFile) {
		$Latest.Checksum32 = (Get-FileHash -Path $exeFile -Algorithm $Latest.ChecksumType32).Hash.ToLower()
	} else {
		throw "iTunes installer not found at '$exeFile' - download may have failed."
	}
	$Latest.Checksum64 = Get-RemoteChecksum -Algorithm $Latest.ChecksumType64 -Url $Latest.URL64
}

function global:au_AfterUpdate($Package) {
	. ..\..\scripts\Invoke-VirusTotalScan.ps1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$url32 = Get-RedirectedUrl -url "$($releases)32"
	$url64 = Get-RedirectedUrl -url "$($releases)64"
	Write-Output 'Download'
	Push-Location $env:TEMP
	$userAgent = [Microsoft.PowerShell.Commands.PSUserAgent]::Chrome
	Invoke-WebRequest -Uri $url32 -OutFile $exeFile -UserAgent $userAgent
	$File = "$(get-location)\mDNSResponder.exe"
	$bonjourMsi = "$(get-location)\Bonjour.msi"
	7z.exe x $exeFile -i!"Bonjour.msi" -y | Out-Null
	if (Test-Path $bonjourMsi) {
		7z.exe x $bonjourMsi -i!"mDNSResponder.exe" -y | Out-Null
	} else {
		Write-Warning "Bonjour.msi not found inside the iTunes installer - Apple may have changed the installer format."
	}

	Write-Output 'Get version'
	if (-not (Test-Path $File)) {
		Write-Output "mDNSResponder.exe not found. Returning fallback version 3.1.0.5."
		Pop-Location
		$Latest = @{ URL32 = $url32; URL64 = $url64; Version = "3.1.0.5" }
		return $Latest
	}

	$version = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion.trim().replace(',','.')
	Write-Output "Version : $version"
	Pop-Location
	if($version -eq "3.1.0.1"){
		$version = "3.1.0.5"
	}

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

update -ChecksumFor none -NoCheckChocoVersion
