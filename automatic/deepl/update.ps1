import-module au

$release = 'https://appdownload.deepl.com/windows/full/DeepLSetup.exe'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
		}
	}
}

function global:au_GetLatest {
	cinst -y deepl --ignore-checksums
	$version=$(ls "$($env:LOCALAPPDATA)\deepl\app*" -Directory).Name.split("-")[1]
	
	$Latest = @{ URL64 = $release; Version = $version }
	return $Latest
}

update -ChecksumFor 64