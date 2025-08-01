$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases	= 'https://feathercoin.com/'

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(Url\s*=\s*)('.*')"        	= "`$1'$($Latest.Url32)'"
			"(Checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(ChecksumType\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_GetLatest {
	$downloadPage = Invoke-WebRequest -Uri $releases -UseBasicParsing
	$url32      = $downloadPage.links | where-object href -match '.exe$' | select-object -expand href | foreach-object { $_ } | Select-Object -First 1

	$version 	= $url32.Split('-') | Where-Object {$_ -Match '\.'} | Where-Object {$_ -notmatch ".exe$"} | Where-Object {$_ -notmatch '\/'}

	return @{
		Url32 	= $url32
		Version = $version
	}
}

update -ChecksumFor 32
