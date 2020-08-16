$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://github.com/ltGuillaume/Redshift-Tray/releases/latest'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]version\s*=\s*)('.*')"      = "`$1'$($Latest.VERSION)'"
		}
		"tools\VERIFICATION.txt"      = @{
			"(?i)(x86:).*"        = "`${1} $($Latest.URL32)"
			"(?i)(checksum:).*" = "`${1} $($Latest.Checksum32)"
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
	Invoke-WebRequest -Uri "https://raw.githubusercontent.com/ltGuillaume/Redshift-Tray/master/LICENSE" -OutFile "$(Get-Location)\tools\license.txt"
	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor none -NoCheckChocoVersion
