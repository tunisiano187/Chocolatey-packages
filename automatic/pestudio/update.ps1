$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://www.winitor.com/tools/pestudio/current/pestudio.zip'

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
	Write-Output 'Get Link'
	#$url32 = "https://www.winitor.com$(((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object  {$_.href -match '.zip'}).href)"
	$url32 = $releases

	Invoke-WebRequest -Uri $url32 -OutFile "$env:temp/pestudio.zip" -UseBasicParsing
	Expand-Archive -Path "$env:temp/pestudio.zip" -DestinationPath "$env:temp/pestudio" -Force
	$File = (Get-ChildItem "$env:temp/pestudio.exe" -Recurse).FullName
	$version = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion.trim().replace(',','.')
	$checksumType = 'SHA256'
	$checksum = (Get-FileHash -Algorithm $checksumType -Path $File).Hash

	$Latest = @{ URL32 = $url32; Version = $version; Checksum32 = $checksum; ChecksumType32 = $checksumType }
	return $Latest
}

update -NoCheckChocoVersion
