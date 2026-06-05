$ErrorActionPreference = 'Stop'
import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$releases = 'https://sourceforge.net/projects/dualmonitortool/rss?path=/'

function global:au_SearchReplace {
	@{
		"legal\VERIFICATION.txt"      = @{
			"(?i)(x86:).*"        				= "`${1} $($Latest.URL32)"
			"(?i)(checksum:).*" 				= "`${1} $($Latest.Checksum32)"
			"(?i)(^\s*checksum\s*type\:\s*).*" 	= "`${1}$($Latest.ChecksumType32)"
		}
	}
}

function global:au_BeforeUpdate {
	# Remove any stale MSI files from previous runs (prevents CHO-112/CHO-377/CHO-409 recurrence)
	Get-ChildItem 'tools' -Filter '*.msi' -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force
	# Use a version-derived fixed filename to avoid SourceForge URL special-character issues with WebClient
	$destPath = "tools\DualMonitorTools-$($Latest.Version).msi"
	Invoke-WebRequest -Uri $Latest.URL32 -OutFile $destPath -UseBasicParsing
	$Latest.Checksum32 = (Get-FileHash -Path $destPath -Algorithm SHA512).Hash
	$Latest.ChecksumType32 = 'sha512'
}

function global:au_AfterUpdate($Package) {
	Import-Module ..\..\scripts\au_extensions.psm1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$File = "$env:TEMP\dualmonitortool.xml"
	Invoke-WebRequest -Uri $releases -OutFile $File
	$xml = Get-Content $File
	$links=$xml | Where-Object {$_ -match '.msi/download'} | Select-Object -First 1
	$url32 = Get-RedirectedUrl ($links.Split('<|>') | Where-Object {$_ -match '.msi/download'})
	$version = (Get-Version $url32).Version

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor none
