$ErrorActionPreference = 'Stop'
import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$releases = 'https://docs.microsoft.com/en-us/sysinternals/downloads/sdelete'

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
	$url32 = (((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match 'SDelete.zip'}).href)[0]
	$ZipFile = "./sdelete.zip"
	Invoke-WebRequest -Uri $url32 -OutFile $ZipFile -UseBasicParsing
	$checksum32 = (Get-FileHash -Path $ZipFile -Algorithm SHA256).Hash
	Expand-Archive $ZipFile -DestinationPath .\sdelete
	$File = $(Get-ChildItem Sdelete.exe -Recurse).FullName
	Write-Output $File
	$version=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion

	# Sysinternals doesn't always bump the exe's FileVersion between releases (e.g. it stayed
	# '2.05' across multiple actual content changes, which previously required a one-off
	# hardcoded version string here -- and would silently mask any future release that also
	# reports '2.05', leaving the checksum stale forever since AU only re-checks it on a
	# detected version change).
	#
	# Use the zip's own checksum as the source of truth for "did anything actually change",
	# instead of trusting the version string. If it's identical to what's already published,
	# report the current nuspec version unchanged so AU correctly sees "no update" (and skips
	# recomputing a checksum that would just be the same value again). Only bump -- using
	# today's date, since FileVersion alone can't be trusted to be unique -- when the content
	# genuinely differs.
	[xml]$nuspec = Get-Content '.\sdelete.nuspec'
	$currentVersion = $nuspec.package.metadata.version
	$currentChecksumMatch = Select-String -Path '.\tools\chocolateyInstall.ps1' -Pattern "^\`$checksum\s*=\s*'([0-9a-fA-F]+)'"
	$currentChecksum = if ($currentChecksumMatch) { $currentChecksumMatch.Matches[0].Groups[1].Value }

	if ($currentChecksum -and $checksum32 -ieq $currentChecksum) {
		$version = $currentVersion
	} elseif ($version -notmatch '\.\d{8}$') {
		$version = "$version.$(Get-Date -Format 'yyyyMMdd')"
	}

	$Latest = @{ URL32 = $url32; Version = $version; Checksum32 = $checksum32; ChecksumType32 = 'sha256' }
	return $Latest
}

update -ChecksumFor none
