$ErrorActionPreference = 'Stop'
import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$releases = 'https://www.ej-technologies.com/download/install4j/files'

function global:au_SearchReplace {
	@{
		"$($Latest.PackageName).nuspec" = @{
            "(\<dependency .+?`"$($Latest.PackageName).install`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
        }
	}
}

function global:au_GetLatest {
	$pageContent = Invoke-WebRequest -Uri $releases
	$regexPattern = 'version:\s*(\d+(\.\d+)*)'
	$versionMatch = $pageContent.Content | Select-String -Pattern $regexPattern -AllMatches

	$version = $versionMatch.Matches[0].Groups[1].Value
	Update-Metadata -key "copyright" -value "(c) $(Get-Date -Format "yyyy") ej-technologies GmbH"

	$Latest = @{ Version = $version }
	return $Latest
}

update -ChecksumFor none
