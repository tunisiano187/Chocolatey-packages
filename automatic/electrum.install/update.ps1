$ErrorActionPreference = 'Stop'
import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$releases = 'https://download.electrum.org/?C=M;O=D'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
		}
		"tools\VERIFICATION.txt"      = @{
			"(?i)(x86:).*"        = "`${1} $($Latest.URL32)"
			"(?i)(checksum32:).*" = "`${1} $($Latest.Checksum32)"
			"(?i)(checksumtype:).*" = "`${1} $($Latest.ChecksumType32)"
		}
	}
}

function global:au_BeforeUpdate {
	Invoke-WebRequest -Uri "https://raw.githubusercontent.com/spesmilo/electrum/master/LICENCE" -OutFile ".\tools\LICENSE.txt"
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	Write-Verbose 'Check Version'
	$version = $((((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links)) | Where-Object {$_.href -match '/$'} | select -First 1).href.replace('/','')
	Write-Verbose "Version : $version"
	$url32 = "https://download.electrum.org/$($version)/electrum-$($version)-setup.exe"

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion
