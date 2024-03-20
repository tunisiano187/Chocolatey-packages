$ErrorActionPreference = 'Continue';
import-module au

$releases = 'https://www.apple.com/itunes/download/win'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$url32 = "$($releases)32"
	$url64 = "$($releases)64"
	$startdir = Get-Location
	$install_fname = 'bonjour.exe'
	Write-Output 'Download'
	Set-Location $env:TEMP
	$exeFile = Join-Path $env:TEMP $install_fname
	$userAgent = [Microsoft.PowerShell.Commands.PSUserAgent]::Chrome
	Invoke-WebRequest -Uri $url32 -OutFile $exeFile -UserAgent $userAgent
	$File = "$(get-location)\mDNSResponder.exe"
	7z.exe x $exeFile
	7z.exe x "$(get-location)\bonjour*.msi"
	Write-Output 'Get version'
	$version=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion.trim().replace(',','.')
	Write-Output "Version : $version"
	Set-Location $startdir

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion
