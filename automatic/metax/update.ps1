$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'https://danhinsley.com/metax/metax.html'

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
	. ..\..\scripts\Invoke-VirusTotalScan.ps1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$page = Invoke-WebRequest -Uri $releases
	$regexPattern = 'V(\d+(\.\d+)*)'
	$versionMatch = $page.Content | Select-String -Pattern $regexPattern -AllMatches
	# Pick the highest version found on the page; filter out bare integers (e.g. "2") that
	# lack a dot, as [version] requires at least Major.Minor and throws otherwise.
	$version = ($versionMatch.Matches | ForEach-Object { $_.Groups[1].Value } |
		Where-Object { $_ -match '\.' } |
		Sort-Object { [version]$_ } | Select-Object -Last 1)
	if (-not $version) { throw "Could not find a valid version string (X.Y) on the metax page" }

	$url32 = "https://www.danhinsley.com/downloads/MetaXSetup.msi"

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor none
