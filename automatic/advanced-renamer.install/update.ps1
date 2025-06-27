$ErrorActionPreference = 'Stop'
import-module AU
Import-Module ..\..\scripts\au_extensions.psm1

$releases = 'https://www.advancedrenamer.com/download'

function global:au_SearchReplace {
	@{
    	".\legal\VERIFICATION.txt" = @{
    		"(?i)(^\s*url(32)?\:\s*).*"        = "`${1}<$($Latest.URL32)>"
    		"(?i)(^\s*checksum(32)?\:\s*).*"   = "`${1}$($Latest.Checksum32)"
    		"(?i)(^\s*checksum\s*type\:\s*).*" = "`${1}$($Latest.ChecksumType32)"
    	}
	}
}

function global:au_BeforeUpdate {
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $Latest.URL32 -keep
	$File = ".\tools\$($FileVersion.Filename)"
	Move-Item -Path $FileVersion.TempFile -Destination $File
	$Latest.Checksum32 = $FileVersion.Checksum
	$Latest.ChecksumType32 = $FileVersion.checksumType
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$Link = ((Invoke-WebRequest -Uri $releases).Links | Where-Object {$_.href -match '.exe'} | Select-Object -First 1).href
	$url32 = "https://www.advancedrenamer.com$Link"
	$version=Get-Version $url32.Replace('_','.')

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor none
