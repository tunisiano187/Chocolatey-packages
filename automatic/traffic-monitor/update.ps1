$ErrorActionPreference = 'Stop'

import-module chocolatey-AU
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"
$releases = 'https://api.github.com/repos/zhongyang219/TrafficMonitor/releases/latest'
$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 2

function global:au_SearchReplace {
	@{
		"tools\VERIFICATION.txt" = @{
			"(32-Bit\s+:).*"  			= "`${1} $($Latest.URL32)"
			"(checksum32\s+:).*" 		= "`${1} $($Latest.Checksum32)"
			"(checksum_type\s+:).*" 	= "`${1} $($Latest.ChecksumType32)"
			"(64-Bit\s+:).*"      		= "`${1} $($Latest.URL64)"
			"(checksum64\s+:).*" 		= "`${1} $($Latest.Checksum64)"
		}
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
	Get-RemoteFiles -Purge -NoSuffix
}

function global:au_AfterUpdate($Package) {
	. ..\..\scripts\Invoke-VirusTotalScan.ps1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo -Latest
	$urls = $tags.assets.browser_download_url
    $url32 = $urls | Where-Object {$_ -match 'x86.zip'}
    $url64 = $urls | Where-Object {$_ -match 'x64.zip'}
	Update-Metadata -key "releaseNotes" -value $tags.html_url
	$version = $tags.tag_name.Tolower().replace('v','')
    if($tags.tag_name -match $version) {
        if($tags.prerelease -match "true") {
            $date = $tags.published_at.ToString("yyyyMMdd")
            $version = "$version-pre$($date)"
        }
    }
	Invoke-WebRequest -Uri "https://raw.githubusercontent.com/zhongyang219/TrafficMonitor/master/LICENSE" -OutFile ".\tools\LICENSE.txt"

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

 update -NoCheckChocoVersion
