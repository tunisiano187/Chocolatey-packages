$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://github.com/bitcoinxt/bitcoinxt/releases/latest'

function global:au_SearchReplace {
	@{
		"$($Latest.PackageName).nuspec" = @{
            "(\<dependency .+?`"$($Latest.PackageName).install`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
        }
	}
}

function global:au_GetLatest {
	Write-Verbose 'Get files'
	$installer = ((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match "-win"} | Where-Object {$_ -match '.exe'} | Select-Object -First 2 | Sort-Object ).href
	Write-Verbose 'Checking version'
	$v=$($installer[0]).split('/')[-2].replace('v','')
	foreach ($char in [int[]][char[]]$v) {
		if($char -gt 65){
			$ver = $char - 64
			$version = "$($version).$($ver)"
		} else {
			$version = "$($version)$([char[]]$char)"
		}
	}
	$Latest = @{ Version = $version }
	return $Latest
}

update -NoCheckChocoVersion
