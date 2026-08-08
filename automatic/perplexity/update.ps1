$ErrorActionPreference = 'Stop'
Import-Module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$baseUrl = 'https://download.todesktop.com/25020447d4kq915'
$latestUrl = "$baseUrl/latest.yml"

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url64bit\s*=\s*)('.*')"          = "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')"         = "`$1'$($Latest.Checksum64)'"
			"(^[$]checksumType64\s*=\s*)('.*')"     = "`$1'$($Latest.ChecksumType64)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$content = (Invoke-WebRequest -Uri $latestUrl -UseBasicParsing).Content
	$version = ($content -split '\r?\n' | Where-Object {$_ -match '^version:'} | Select-Object -First 1) -replace '^version:\s*', ''
	$version = $version.Trim()

	$fileName = "Perplexity AI Setup $version-x64.exe"
	$url64 = "$baseUrl/$([uri]::EscapeDataString($fileName))"

	Write-Output "Version : $version"
	Write-Output "URL64   : $url64"

	return @{
		Version = $version
		URL64   = $url64
	}
}

update -ChecksumFor 64
