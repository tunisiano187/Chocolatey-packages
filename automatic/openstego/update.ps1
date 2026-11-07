$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'https://api.github.com/repos/syvaidya/openstego/releases/latest'

function global:au_SearchReplace {
	@{
		"$($Latest.PackageName).nuspec" = @{
            "(\<dependency .+?`"$($Latest.PackageName).install`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
        }
	}
}

function global:au_AfterUpdate($Package) {
	. ..\..\scripts\Invoke-VirusTotalScan.ps1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
    $release = Invoke-RestMethod $releases
    $version = $release.tag_name.Replace('v','').Split('-') | Where-Object {$_ -match '\.'}
    if ($release.prerelease -match 'true') {
        $date = $release.published_at.ToString('yyyyMMdd')
        $version = "$version-pre$($date)"
    }
    return @{ Version = $version }
}

update -ChecksumFor none
