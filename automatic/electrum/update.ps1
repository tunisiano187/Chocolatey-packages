import-module au

$releases = 'https://download.electrum.org/?C=M;O=D'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]version\s*=\s*)('.*')"      	= "`$1'$($Latest.Version)'"
		}
	}
}

function global:au_GetLatest {
	Write-Verbose 'Check Version'
	$version = $((((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links)) | Where-Object {$_.href -match '/$'} | Select-Object -First 1).href.replace('/','')
	Write-Verbose "Version : $version"
	$url32 = "https://download.electrum.org/$($version)/electrum-$($version)-setup.exe"

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32