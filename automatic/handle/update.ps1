$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://docs.microsoft.com/fr-be/sysinternals/downloads/handle'

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
	$url32 = (((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match 'Handle.zip'}).href)[0]
	$ZipFile = "./Handle.zip"
	Invoke-WebRequest -Uri $url32 -OutFile $ZipFile -UseBasicParsing
	Expand-Archive $ZipFile -DestinationPath .\handle
	$File = $(Get-ChildItem handle.exe -Recurse).FullName
	Write-Output $File
	$version=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32