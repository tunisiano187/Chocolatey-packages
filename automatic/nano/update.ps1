$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://files.lhmouse.com/nano-win/'

function global:au_SearchReplace {
	@{
		"$($Latest.PackageName).nuspec" = @{
			"(\<dependency .+?`"$($Latest.PackageName)-win`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
		}
	}
}

function global:au_GetLatest {
	Write-Verbose 'Get files'
	$filename = (Invoke-WebRequest -Uri $releases -UseBasicParsing).Links.href | Where-Object {$_ -match '\.7z'} | Sort-Object | Select-Object -Last 1
	Write-Verbose 'Checking version'
	$version = (choco search nano-win | Where-Object {$_ -match 'nano-win'}).split(' ') | Where-Object {$_ -match '\.'}

	$url32 = $releases + $filename
	Write-Verbose "Version : $version"

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion
