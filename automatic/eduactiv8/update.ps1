$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://sourceforge.net/projects/eduactiv8/rss?path=/Windows'

function global:au_SearchReplace {
	@{
		"legal\VERIFICATION.txt"      = @{
			"(?i)(x86:).*"        				= "`${1} $($Latest.URL32)"
			"(?i)(checksum:).*" 				= "`${1} $($Latest.Checksum32)"
			"(?i)(^\s*checksum\s*type\:\s*).*" 	= "`${1}$($Latest.ChecksumType32)"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$File = "$env:TEMP\eduactiv8.xml"
	Invoke-WebRequest -Uri $releases -OutFile $File
	$xml = Get-Content $File
	$links=$xml | Where-Object {$_ -match 'win.zip/download'} | Where-Object {$_ -match 'link'}  | Select-Object -First 1
	$url32 = Get-RedirectedUrl ($links.Split('<|>') | Where-Object {$_ -match 'win.zip/download'})
	$version = (Get-Version $url32).Version
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $url32 -keep
	Move-Item -Path $FileVersion.TempFile -Destination "tools\eduactiv8-$($version)-win.zip"

	$Latest = @{ URL32 = $url32; Version = $version; Checksum32 = $FileVersion.CHECKSUM; ChecksumType32 = $FileVersion.ChecksumType }
	return $Latest
}

update -ChecksumFor none
