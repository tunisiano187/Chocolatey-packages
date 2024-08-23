$ErrorActionPreference = 'Stop'
import-module au

$url32 = 'https://www.odrive.com/downloaddesktop?platform=win'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$compare="6452"
	$File = Join-Path $env:TEMP "Odrive.exe"
	Invoke-WebRequest -Uri $url32 -OutFile $File
	$version=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion
	$version=$version.replace('.00.','.0.')
	if($version.Split('.')[0] -eq "1")
	{
		if($version.Split('.')[1] -lt $compare)
		{
			$version=$version.replace(".$($version.Split('.')[1]).",".$($compare).$($version.Split('.')[1]).")
		}
	}

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion
