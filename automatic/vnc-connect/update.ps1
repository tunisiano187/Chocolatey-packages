$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://realvnc.com/en/connect/download/vnc/'

Add-Type -AssemblyName System.IO.Compression.FileSystem
function Unzip
{
    param([string]$zipfile, [string]$outpath)
    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
}

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$page = (Invoke-WebRequest -Uri $releases -UseBasicParsing).Content
	$regex = 'data-file="(https://downloads\.realvnc\.com/download/file/vnc\.files/VNC-Server-[^"]+-Windows-msi\.zip)"'
	if ($page -match $regex) {
		$url32 = $matches[1]
	}

	$version=$(Get-Version $url32).Version

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32