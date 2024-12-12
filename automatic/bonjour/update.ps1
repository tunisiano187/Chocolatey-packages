$ErrorActionPreference = 'Continue';
import-module au

$releases = 'https://www.apple.com/itunes/download/win'

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
	$Latest.Checksum32 = Get-RemoteChecksum -Algorithm $Latest.ChecksumType32 -Url $Latest.URL32
	$Latest.Checksum64 = Get-RemoteChecksum -Algorithm $Latest.ChecksumType32 -Url $Latest.URL64
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$url32 = Get-RedirectedUrl -url "$($releases)32"
	$url64 = Get-RedirectedUrl -url "$($releases)64"
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
	if($version -eq "3.1.0.1"){
		$version = "3.1.0.4"
	}

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

update -ChecksumFor none -NoCheckChocoVersion
