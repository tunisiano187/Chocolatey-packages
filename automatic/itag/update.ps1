$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://www.itagsoftware.com/iTagInstaller.exe'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumtype\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_GetLatest {
	$url32 = $releases

	$File = Join-Path $env:TEMP "iTag.exe"
	Invoke-WebRequest -Uri $url32 -OutFile $File
	Start-Process -FilePath $File -ArgumentList "/S" -Wait
	while (!(Test-Path $(join-path ${env:ProgramFiles(x86)} "iTag\iTag.exe"))) {
		Start-Sleep -Seconds 1
	}
	$version=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($(join-path ${env:ProgramFiles(x86)} "iTag\iTag.exe")).FileVersion

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32
