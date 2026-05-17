$ErrorActionPreference = 'Stop'
import-module chocolatey-AU
. ..\..\scripts\Get-FileVersion.ps1

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
	Import-Module ..\..\scripts\au_extensions.psm1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$url32 = "https://download.sysinternals.com/files/Contig.zip"
	$page = Invoke-WebRequest -Uri "https://learn.microsoft.com/en-us/sysinternals/downloads/contig" -UseBasicParsing
	$versionPattern = 'Contig\s+v(\d+(\.\d+)*)'
	$match = [regex]::Match($page.Content, $versionPattern)
	if (-not $match.Success) { throw "Could not find Contig version on MS Learn page" }
	$version = $match.Groups[1].Value

	$fileVersion = Get-FileVersion $url32
	Update-Metadata -key "copyright" -value "© 1998-$(Get-Date -Format "yyyy") Mark Russinovich"

	return @{
		URL32         = $url32
		Checksum32    = $fileVersion.Checksum
		ChecksumType32 = $fileVersion.ChecksumType
		Version       = $version
	}
}

update -ChecksumFor none -NoCheckChocoVersion
