$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://sourceforge.net/projects/eduactiv8/rss?path=/Windows'

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
	$File = "$env:TEMP\eduactiv8.xml"
	Invoke-WebRequest -Uri $releases -OutFile $File
	$xml = Get-Content $File
	$links=$xml | Where-Object {$_ -match 'win.zip/download'} | Where-Object {$_ -match 'link'}  | Select-Object -First 1
	$url32 = Get-RedirectedUrl ($links.Split('<|>') | Where-Object {$_ -match 'win.zip/download'})
	$version = (Get-Version $url32).Version

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32
