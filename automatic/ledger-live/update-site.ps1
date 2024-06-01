$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://download.live.ledger.com/'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
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
	$Page = Invoke-WebRequest -Uri $releases
	$exeFiles = $Page.Links.href | Where-Object { $_ -match "-win-x64\.exe" }
	$latestExe = $exeFiles | Sort-Object {
		[version]($_ -match "ledger-live-desktop-([0-9]+\.[0-9]+\.[0-9]+-[a-z0-9\.]+)-win-x64\.exe")
	} | Select-Object -Last 1
	$version=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion