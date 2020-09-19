$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://static.idriveonlinebackup.com/downloads/idrivethin/thin_version.js'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
		}
	}
}

function global:au_GetLatest {
	$url32 = (Invoke-WebRequest -Uri $releases -UseBasicParsing).content.split("'") | Where-Object {$_ -match 'exe'}

	$File = Join-Path($(Split-Path $script:MyInvocation.MyCommand.Path)) "Odrive.exe"
	Invoke-WebRequest -Uri $url32 -OutFile $File
	$version=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion

	$Latest = @{ URL32 = $url32; Version = $version.trim }
	return $Latest
}

update -ChecksumFor 32
