$ErrorActionPreference = 'Stop'
import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1
. ..\..\scripts\Get-FileVersion.ps1

$releases = 'https://sourceforge.net/projects/pwgen-win/rss?path=/Password%20Tech'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$File = "$env:TEMP\pwgen.install.xml"
	Invoke-WebRequest -Uri $releases -OutFile $File
	$xml = Get-Content $File

	# RSS is newest-first; grab the first Setup.exe entry
	$links = $xml | Where-Object { $_ -match 'Setup\.exe/download' } | Where-Object { $_ -match 'link' } | Select-Object -First 1
	$url32 = ($links.Split('<|>') | Where-Object { $_ -match '/download' })[0]

	if (-not $url32) {
		throw "Could not find Setup.exe download link in RSS feed"
	}

	$version = (Get-Version $url32).Version

	# Use Get-FileVersion to compute checksum without bundling the installer; Get-FileVersion
	# uses the second-to-last URL segment as filename, which is the real exe name, avoiding
	# the /download suffix path error that -ChecksumFor 32 triggers.
	$fileInfo = Get-FileVersion $url32
	$checksum = $fileInfo.Checksum
	$checksumType = $fileInfo.ChecksumType

	$Latest = @{
		URL32          = $url32
		Version        = $version
		Checksum32     = $checksum
		ChecksumType32 = $checksumType
	}
	return $Latest
}

update -ChecksumFor none
