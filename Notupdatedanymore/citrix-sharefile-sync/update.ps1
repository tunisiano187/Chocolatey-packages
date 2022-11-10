$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://www.citrix.com/downloads/sharefile/clients-and-plug-ins/citrix-files-for-windows.html'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_GetLatest {
	$urls=$(((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_.rel -match '.msi'}).rel)
	$url32 = "https:$($urls)"

	$version = $url32.split('?')[0].split('v')[-1].replace('.msi','')
	$url32 = "https://dl.sharefile.com/sync2win"

	$Latest = @{ URL32 = $url32; Version = $version }

	Invoke-WebRequest -Uri 'https://www.citrix.com/downloads/sharefile/clients-and-plug-ins/citrix-files-for-windows.html' -OutFile "$env:TEMP\sharefile.html"
	return $Latest
}

update -checksumfor 32 -NoCheckChocoVersion
