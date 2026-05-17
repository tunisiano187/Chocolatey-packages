import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	. ..\..\scripts\Invoke-VirusTotalScan.ps1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	# SourceForge latest/download redirects to the jar file URL which contains the version
	$redirectUrl = Get-RedirectedUrl 'http://sourceforge.net/projects/projectlibre/files/latest/download'
	if (-not $redirectUrl) {
		throw "Could not follow SourceForge redirect"
	}

	# Extract version from URL like: .../ProjectLibre/1.9.8/projectlibre-1.9.8.jar
	$versionMatch = $redirectUrl | Select-String -Pattern '/ProjectLibre/([\d.]+)/'
	if (-not $versionMatch -or $versionMatch.Matches.Count -eq 0) {
		throw "Could not extract version from redirect URL: $redirectUrl"
	}
	$version = $versionMatch.Matches[0].Groups[1].Value

	# Version 1.9.x distributes MSI for Windows (no EXE available)
	$url32 = Get-RedirectedUrl "https://sourceforge.net/projects/projectlibre/files/ProjectLibre/$version/ProjectLibre-$version.msi/download"
	if (-not $url32) {
		throw "Could not get MSI download URL for version $version"
	}

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32
