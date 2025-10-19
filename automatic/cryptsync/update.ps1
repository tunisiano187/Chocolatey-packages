$ErrorActionPreference = 'Stop'

import-module chocolatey-AU
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"
$releases = 'https://api.github.com/repos/stefankueng/CryptSync/releases/latest'
$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 2

function global:au_SearchReplace {
	@{
		"tools\chocolateyinstall.ps1" = @{
			"(^[$]url32\s*=\s*)('.*')"      	= "`$1'$($Latest.URL32)'"
			"(^[$]checksum32\s*=\s*)('.*')" 	= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType32\s*=\s*)('.*')"	= "`$1'$($Latest.checksumType32)'"
			"(^[$]url64\s*=\s*)('.*')"      	= "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" 	= "`$1'$($Latest.Checksum64)'"
			"(^[$]checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.checksumType64)'"
		}
	}
}

function global:au_BeforeUpdate {
	Invoke-WebRequest -Uri "https://raw.githubusercontent.com/stefankueng/CryptSync/master/LICENSE" -OutFile ".\tools\LICENSE.txt"
}

function global:au_AfterUpdate($Package) {
	Import-Module ..\..\scripts\au_extensions.psm1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo -Latest
	$urls = $tags.assets.browser_download_url
    $url32 = $urls | Where-Object {$_ -match 'Sync-'}
    $url64 = $urls | Where-Object {$_ -match 'Sync64-'}
	$version = $tags.tag_name.Tolower().replace('v','')
    Update-Metadata -key "releaseNotes" -value $tags.html_url
	if($tags.tag_name -match $version) {
        if($tags.prerelease -match "true") {
            $date = $tags.published_at.ToString("yyyyMMdd")
            $version = "$version-pre$($date)"
        }
    }

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

 update -NoCheckChocoVersion
