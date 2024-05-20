$ErrorActionPreference = 'Stop'
import-module au

$release = 'https://shark007.net/files/Shark007Codecs.7z'

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
	$File = "tools\Shark007Codecs.7z"
	Invoke-WebRequest -Uri $Latest.URL32 -OutFile $File
	$Latest.Checksum32 = Get-FileHash -Path $File -Algorithm $env:ChocolateyChecksumType
	$Latest.ChecksumType32 = $env:ChocolateyChecksumType
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$page = Invoke-WebRequest -Uri "https://shark007.net/x64components1.html"
	$regexPattern = 'version (\d+(\.\d+)*)'
	$versionMatch = $page.Content | Select-String -Pattern $regexPattern -AllMatches
	$version = $versionMatch.Matches[0].Groups[1].Value

	$Latest = @{ URL32 = $release; Version = $version }
	return $Latest
}

update -ChecksumFor none