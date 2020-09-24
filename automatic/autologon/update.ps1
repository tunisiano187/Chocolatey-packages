$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://download.sysinternals.com/files/AutoLogon.zip'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_GetLatest {
	$url32 = $releases
	$ZipFile = "./autologon.zip"
	Invoke-WebRequest -Uri $url32 -OutFile $ZipFile -UseBasicParsing
	Expand-Archive $ZipFile -DestinationPath .\autologon
	$File = $(Get-ChildItem autologon.exe -Recurse).FullName
	Write-Output $File
	$version=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion
	if($version -eq '3.10') {
		$version = '3.10.0.20200924'
	}

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32
