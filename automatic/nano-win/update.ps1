$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://files.lhmouse.com/nano-win/'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]file\s*=\s*)('.*')"      			= "`$1'$($Latest.FileName)'"
		}
		"tools\VERIFICATION.txt" = @{
			"(^Version\s+:).*"  					= "`${1} $($Latest.Version)"
			"(^URL\s+:).*"      					= "`${1} $($Latest.URL32)"
			"(^Checksum\s+:).*" 					= "`${1} $($Latest.Checksum32)"
	  		"(^ChecksumType\s+:).*" 				= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_GetLatest {
	Write-Verbose 'Get files'
	$filename = ((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match '.7z'} | Select-Object -Last 1).href
	Write-Verbose 'Checking version'
	$version=$($filename).split('v|g')[-2].replace('-','.')
	$version=$version.Substring(0,$version.Length-1)
	Invoke-WebRequest -Uri "https://github.com/lhmouse/nano-win/blob/master/COPYING" -OutFile "tools/LICENSE.md"

	$url32 = $releases + $filename
	Write-Verbose "Version : $version"

	$Latest = @{ URL32 = $url32; Version = $version; FileName = $filename }
	return $Latest
}

function global:au_BeforeUpdate() {
	Write-Output "Downloading $($Latest.Version) installer"
	Get-RemoteFiles -Purge -NoSuffix
}

update -ChecksumFor 32 -NoCheckChocoVersion