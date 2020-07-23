import-module au

$releases = 'https://github.com/ltGuillaume/Redshift-Tray/releases/latest'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]version\s*=\s*)('.*')"      = "`$1'$($Latest.VERSION)'"
		}
	}
}

function global:au_GetLatest {
	Write-Verbose 'Check Folder'
	$url32 = $(((((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links)) | Where-Object {$_.href -match '.zip'}).href)[0]
	Write-Verbose 'Checking version'
	$version = $url32.split('_')[-1].replace('.zip','')
	Write-Verbose "Version : $version"
	$url32 = "https://github.com$($url32)";
	Invoke-WebRequest -Uri $url32 -OutFile "$(Get-Location)\tools\redshift-tray.zip"

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32