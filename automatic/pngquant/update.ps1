$ErrorActionPreference = 'Stop'
import-module au

$url32 = 'https://pngquant.org/pngquant-windows.zip'

Add-Type -AssemblyName System.IO.Compression.FileSystem
function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$page=Invoke-WebRequest -uri "https://pngquant.org/"
	$r = [regex]"\(v(.*)\)"
	$match = $r.match($page.content)
	$version = $match.groups[1].value
	if($version -eq "2.17.0") {
		$version="2.17.0.2022012001"
	}
	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion