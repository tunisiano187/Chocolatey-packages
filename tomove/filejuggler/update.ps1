$ErrorActionPreference = 'Stop'
import-module au

$release = 'https://www.filejuggler.com/download/filejuggler.exe'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumtype\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	choco ipgrade -y autohotkey
	Write-Output 'Check Folder'
	$File = "$($env:Temp)\Filejuggler.exe"
	Write-Output 'Download'
	Invoke-WebRequest -Uri $release -OutFile $File
	[version]$version=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).ProductVersion
	Write-Output "Version : $version"
	$url32 = $release
	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32
