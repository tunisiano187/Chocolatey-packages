$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

function global:au_SearchReplace {
	@{
		'tools\chocolateyInstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
        }
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$url32 = "https://www.nirsoft.net/utils/sysexp_setup.exe"
	$pageContent = Invoke-WebRequest -Uri "https://www.nirsoft.net/utils/sysexp.html" -UseBasicParsing
	$regexPattern = 'SysExporter v(\d+(\.\d+)*)'
	$versionMatch = $pageContent.Content | Select-String -Pattern $regexPattern -AllMatches
	$version = $versionMatch.Matches[0].Groups[1].Value
	Update-Metadata -key "copyright" -value "© $(Get-Date -Format "yyyy") NirSoft"

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update
