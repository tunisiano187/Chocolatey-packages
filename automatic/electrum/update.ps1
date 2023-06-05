$ErrorActionPreference = 'Stop'
import-module au

function global:au_SearchReplace {
	@{
		"$($Latest.PackageName).nuspec" = @{
            "(\<dependency .+?`"$($Latest.PackageName).install`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
        }
	}
}

function global:au_GetLatest {
	Write-Verbose 'Check Version'
	$version = $(choco search electrum.install | Where-Object {$_ -match 'electrum'}).split(' ')[1]
	Write-Verbose "Version : $version"
	$url32 = "https://download.electrum.org/$($version)/electrum-$($version)-setup.exe"

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor None
