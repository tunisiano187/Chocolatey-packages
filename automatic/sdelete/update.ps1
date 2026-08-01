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
	$response = Invoke-WebRequest -Uri $url32 -OutFile $ZipFile -UseBasicParsing -PassThru
	Expand-Archive $ZipFile -DestinationPath .\sdelete
	$File = $(Get-ChildItem Sdelete.exe -Recurse).FullName
	Write-Output $File
	$version=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion

	# Sysinternals doesn't always bump the exe's FileVersion between releases (e.g. it stayed
	# '2.05' across multiple actual content changes, which previously required a one-off
	# hardcoded version string here -- and would silently mask any future release that also
	# reports '2.05', leaving the checksum stale forever since AU only re-checks it on a
	# detected version change). Append the zip's Last-Modified date instead, so the reported
	# version stays unique/monotonic whenever FileVersion alone is ambiguous.
	$lastModified = [DateTime]$response.Headers['Last-Modified']
	$dateSuffix = $lastModified.ToString('yyyyMMdd')
	if ($version -notmatch "\.$dateSuffix$") {
		$version = "$version.$dateSuffix"
	}

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32
