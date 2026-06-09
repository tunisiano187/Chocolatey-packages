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
			"(^[$]url64\s*=\s*)('.*')"      		= "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum64)'"
			"(^[$]checksumType64\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType64)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$File = "$env:TEMP\pwgen.portable.xml"
	Invoke-WebRequest -Uri $releases -OutFile $File
	$xml = Get-Content $File

	# RSS is newest-first; grab the first portable.zip entry
	$links = $xml | Where-Object { $_ -match 'portable\.zip/download' } | Where-Object { $_ -match 'link' } | Select-Object -First 1
	$url = ($links.Split('<|>') | Where-Object { $_ -match '/download' })[0]

	if (-not $url) {
		throw "Could not find portable.zip download link in RSS feed"
	}

	$version = (Get-Version $url).Version

	# Use Get-FileVersion to compute checksum without bundling the file in the package
	$fileInfo = Get-FileVersion $url
	$checksum = $fileInfo.Checksum
	$checksumType = $fileInfo.ChecksumType

	$Latest = @{
		URL32          = $url
		URL64          = $url
		Version        = $version
		Checksum32     = $checksum
		ChecksumType32 = $checksumType
		Checksum64     = $checksum
		ChecksumType64 = $checksumType
	}
	return $Latest
}

update -ChecksumFor none
