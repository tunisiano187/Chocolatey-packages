$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://thebrain.com/download'

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
	Update-Metadata -key "releaseNotes" -value $Latest.ReleaseNotes
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$url32 = (((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match 'DirectDownload'} | Where-Object {$_ -match "Download for Windows"} ).href)[0]
	$ReleasesNotes = (((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match 'Release notes'} ).href)
	$url32 = Get-RedirectedUrl $url32

	$File = "$($env:TEMP)\thebrain.exe"
	Invoke-WebRequest -Uri $url32 -OutFile $File
	$version=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion

	$Latest = @{ URL32 = $url32; Version = $version; ReleaseNotes = $ReleasesNotes }
	return $Latest
}

update -ChecksumFor 32
