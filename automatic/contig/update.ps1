$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

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
	$url32 = "https://download.sysinternals.com/files/Contig.zip"
	$page=Invoke-WebRequest -Uri "https://learn.microsoft.com/en-us/sysinternals/downloads/contig" -UseBasicParsing
	$versionPattern = 'Contig\s+v(\d+(\.\d+)*)'
  	$match = [regex]::Match($page.Content, $versionPattern)
	$version = $match.Groups[1].Value

	Update-Metadata -key "copyright" -value "© 1998-$(Get-Date -Format "yyyy") Mark Russinovich"

	$Latest = @{ URL32 = $url32; Checksum32 = $checksum32; ChecksumType32 = $env:ChocolateyChecksumType; Version = $version }
	return $Latest
}

update -ChecksumFor none -NoCheckChocoVersion
