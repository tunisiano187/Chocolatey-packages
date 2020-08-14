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

function global:au_GetLatest {
	$url32 = "$($releases)32"
	$url64 = "$($releases)64"
	$install_fname = 'bonjour.exe'
	Write-Output 'Download'
	$exeFile = Join-Path $env:TEMP $install_fname
	Invoke-WebRequest -Uri $url32 -OutFile $exeFile
	$File = "$env:temp\mDNSResponder.exe"
	7z.exe x $exeFile
	7z.exe x "$(get-location)\bonjour*.msi"
	Write-Output 'Get version'
	$version=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion.trim()
	Write-Output "Version : $version"

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

update -ChecksumFor 32