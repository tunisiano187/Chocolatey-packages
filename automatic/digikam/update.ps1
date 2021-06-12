$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://download.kde.org/stable/digikam/'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url64\s*=\s*)('.*')"      	= "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" 	= "`$1'$($Latest.Checksum64)'"
			"(^[$]checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
		}
	}
}

function global:au_GetLatest {
	Write-Output 'Check Folder'
	$version = ((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object  {$_.href -match '^\d+([.]\d+)?'} | ForEach-Object {($_.href -replace '[^.\d]', '')} | Measure-Object -Max).Maximum
	$url32 = Invoke-WebRequest -Uri "https://download.kde.org/stable/digikam/$($version)/"
	$url64 = "https://download.kde.org/stable/digikam/$($version)/digiKam-$($version)-Win64.exe"

	$Latest = @{ URL64 = $url64; Version = $version }
	return $Latest
}

update -ChecksumFor 64
