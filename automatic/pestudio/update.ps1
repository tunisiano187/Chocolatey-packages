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

	Invoke-WebRequest -Uri $url32 -OutFile "$env:temp/pestudio.zip"
	Expand-Archive -Path "$env:temp/pestudio.zip" -DestinationPath "$env:temp/pestudio" -Force
	$File = (Get-ChildItem "$env:temp/pestudio.exe" -Recurse).FullName
	$version = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion.trim().replace(',','.')
	$r = Invoke-WebRequest -Uri $releases
	$checksum = ($r.ParsedHTML.GetElementsByTagName('code') | Select-Object innerHTML).innerHTML
	$checksumType = 'SHA256'

	$Latest = @{ URL32 = $url32; Checksum32 = $checksum; ChecksumType32 = $checksumType; Version = $version }
	return $Latest
}

update -ChecksumFor none