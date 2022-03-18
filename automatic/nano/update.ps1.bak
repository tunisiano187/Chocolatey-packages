$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://files.lhmouse.com/nano-win/?C=M&O=D'

function global:au_SearchReplace {
	@{
		"$($Latest.PackageName).nuspec" = @{
			"(\<dependency .+?`"$($Latest.PackageName)-win`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
		}
	}
}

function global:au_GetLatest {
	Write-Verbose 'Get files'
	$url32 = ((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match '.7z'} | Select-Object -First 1).href
	Write-Verbose 'Checking version'
	$version=$($url32).split('v|g')[-2].replace('-','.')
	$version=$version.Substring(0,$version.Length-1)

	Write-Verbose "Version : $version"

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion