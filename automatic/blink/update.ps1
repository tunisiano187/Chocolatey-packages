$ErrorActionPreference = 'Stop'
import-module au

$release = 'https://blink.sipthor.net/download.phtml?download&os=nt'


function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
		}
		"tools\VERIFICATION.txt"      = @{
			"(?i)(x86:).*"        				= "`${1} $($Latest.URL32)"
			"(?i)(checksumtype:).*" 			= "`${1} $($Latest.ChecksumType32)"
			"(?i)(checksum32:).*" 				= "`${1} $($Latest.Checksum32)"
		}
	}
}

function global:au_BeforeUpdate {
	Import-Module VirusTotalAnalyzer -NoClobber -Force
	New-VirusScan -ApiKey $env:VT_APIKEY -Url $Latest.URL32
	Start-Sleep -Seconds 60
	$vt = (Get-VirusScan -ApiKey $env:VT_APIKEY -Url $Latest.URL32).data.attributes.reputation
	if ( $vt -gt 5 ) {
	  Write-Error "Ignoring $($Latest.PackageName) package due to virus total results - $vt positives"
	  return 'ignore'
	}
}

function global:au_GetLatest {
	$url32 = $release
	$File = Join-Path($(Split-Path $script:MyInvocation.MyCommand.Path)) "tools\blink.exe"
	(new-object System.Net.WebClient).DownloadFile($url32,$File)
	$version=$(Get-Command $File).FileVersionInfo.ProductVersion.trim()

	$Latest = @{ URL32 = $url32; Version = $version}
	return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion
