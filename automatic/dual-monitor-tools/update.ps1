$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'https://sourceforge.net/projects/dualmonitortool/rss?path=/'

function global:au_SearchReplace {
	@{
		"legal\VERIFICATION.txt"      = @{
			"(?i)(x86:).*"        				= "`${1} $($Latest.URL32)"
			"(?i)(checksum:).*" 				= "`${1} $($Latest.Checksum32)"
			"(?i)(^\s*checksum\s*type\:\s*).*" 	= "`${1}$($Latest.ChecksumType32)"
		}
	}
}

function global:au_BeforeUpdate {
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $Latest.URL32 -keep
	Move-Item -Path $FileVersion.TempFile -Destination "tools\$($FileVersion.FileName)"
	$Latest.Checksum32 = $FileVersion.Checksum
	$Latest.ChecksumType32 = $FileVersion.checksumType
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$File = "$env:TEMP\dualmonitortool.xml"
	Invoke-WebRequest -Uri $releases -OutFile $File
	$xml = Get-Content $File
	$links=$xml | Where-Object {$_ -match '.msi/download'} | Select-Object -First 1
	$url32 = Get-RedirectedUrl ($links.Split('<|>') | Where-Object {$_ -match '.msi/download'})
	$version = (Get-Version $url32).Version

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor none
