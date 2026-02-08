$ErrorActionPreference = 'Stop'
import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

function global:au_SearchReplace {
	@{
		"$($Latest.PackageName).nuspec" = @{
            "(\<dependency .+?`"$($Latest.PackageName).install`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
        }
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$choc = choco search install4j.install -s https://community.chocolatey.org/api/v2 | Where-Object {$_ -match "install4j.install"}

	if (-not $choc) {
		throw "Could not find install4j.install package in Chocolatey repo"
	}

	$parts = $choc.Split(" ")
	if ($parts.Count -lt 2) {
		throw "Could not parse version from choco search result"
	}

	$version = $parts[1]
	Update-Metadata -key "copyright" -value "© $(Get-Date -Format "yyyy") ej-technologies GmbH"

	$Latest = @{ Version = $version }
	return $Latest
}

update -ChecksumFor none
