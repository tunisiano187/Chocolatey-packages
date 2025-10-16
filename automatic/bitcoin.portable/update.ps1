$ErrorActionPreference = 'Stop'
import-module Chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$releases = 'https://github.com/bitcoin/bitcoin/releases/latest'
$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 2

if ($MyInvocation.InvocationName -ne '.') {
    function global:au_SearchReplace {
        @{
            'tools/chocolateyInstall.ps1' = @{
                "(^[$]url64\s*=\s*)('.*')"            = "`$1'$($Latest.URL64)'"
                "(^[$]checksum64\s*=\s*)('.*')"       = "`$1'$($Latest.Checksum64)'"
                "(^[$]checksumType64\s*=\s*)('.*')"   = "`$1'$($Latest.ChecksumType64)'"
            }
        }
    }
}

function global:au_AfterUpdate($Package) {
	. ..\..\scripts\Invoke-VirusTotalScan.ps1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
    Write-Verbose 'Get files'
	$tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo -Latest
    Update-Metadata -key "releaseNotes" -value $tags.html_url

    Write-Verbose 'Get version'
    $version = $tags.name.Split(' ')[-1]
    $folder = "https://bitcoincore.org/bin/$(((Invoke-WebRequest -Uri 'https://bitcoincore.org/bin/' -UseBasicParsing).Links | Where-Object {$_.href -match $version} | Select-Object -Last 1).href)"

	Write-Verbose 'Get files'
	$file = $(((Invoke-WebRequest -Uri $folder -UseBasicParsing).Links | Where-Object {$_.href -match ".zip"} | Where-Object {$_.href -match "win64"} | Where-Object {$_.href -notmatch "debug" } | Where-Object {$_.href -notmatch "unsigned" }).href)
    $url64 = "$folder$file"
	#$url64 = "https://github.com/$(((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match ".zip"} | Select-Object -First 1).href)"

    return @{ URL64 = $url64; Version = $version }
}

update -ChecksumFor 64
