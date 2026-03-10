$ErrorActionPreference = 'Stop'
import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$url = 'https://javadl-esd-secure.oracle.com/update/jut/JavaUninstallTool.exe'

function global:au_SearchReplace {
	@{
		'tools/ChocolateyInstall.ps1' = @{
			"(^\`$checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
			"(^\`$checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $url
	$Latest = @{
		URL32          = $url
		Version        = $FileVersion.Version
		Checksum32     = $FileVersion.Checksum
		ChecksumType32 = $FileVersion.ChecksumType
	}
	return $Latest
}

update -ChecksumFor none
