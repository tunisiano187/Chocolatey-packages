$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://johnsad.ventures/software/backgroundswitcher/windows/'
$padVersionUnder = '5.4.0.3'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
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
	$jbs = (Invoke-WebRequest -Uri $releases -UseBasicParsing)
	$url32 = ($jbs.Links | Where-Object {$_ -match 'exe'})[0].href

	$File = Join-Path $env:TEMP "SwitcherSetup.exe"
	Invoke-WebRequest -Uri $url32 -OutFile $File
	Start-Process -FilePath $File -ArgumentList "/S" -Wait
	while (!(Test-Path $(join-path ${env:ProgramFiles(x86)} "johnsadventures.com\John's Background Switcher\BackgroundSwitcher.exe"))) {
		Start-Sleep -Seconds 1
	}
	$version=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($(join-path ${env:ProgramFiles(x86)} "johnsadventures.com\John's Background Switcher\BackgroundSwitcher.exe")).FileVersion

	$Latest = @{ URL32 = $url32; Version = Get-FixVersion $version -OnlyFixBelowVersion $padVersionUnder }
	return $Latest
}

update -ChecksumFor 32
