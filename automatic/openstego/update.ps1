$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

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
	$choc=$(choco search openstego.install | Where-Object {$_ -match "openstego"})
	$version = $choc.Split(" ")[1]

	$Latest = @{ Version = $version }
	return $Latest
}

update -ChecksumFor none
