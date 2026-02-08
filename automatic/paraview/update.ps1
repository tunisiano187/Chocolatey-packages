$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'https://www.paraview.org/files/'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_BeforeUpdate {
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $Latest.URL32
	$Latest.Checksum32 = $FileVersion.Checksum
	$Latest.ChecksumType32 = $FileVersion.checksumType
}

function global:au_AfterUpdate($Package) {
	. ..\..\scripts\Invoke-VirusTotalScan.ps1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$webResponse = Invoke-WebRequest -Uri $releases -UseBasicParsing
	$folderLink = $webResponse.Links | Where-Object {$_.href -match 'v[0-9].'} | Select-Object -Last 1
	
	if (-not $folderLink) {
		throw "Could not find version folder link"
	}
	
	$folder = $folderLink.href
	
	$fileResponse = Invoke-WebRequest -Uri "$releases$folder" -UseBasicParsing
	$fileLink = $fileResponse.Links | Where-Object {$_.href -match ".msi"} | Select-Object -Last 1
	
	if (-not $fileLink) {
		throw "Could not find .msi file link"
	}
	
	$file = ($fileLink.href).replace('.0&','&')
	$url = "https://www.paraview.org/paraview-downloads/download.php?submit=Download&version=$folder&type=binary&os=Windows&downloadFile=$file"
	$version = $file.Split('-') | Where-Object {$_ -match '^[0-9]\.[0-9]'} | Select-Object -First 1

	$Latest = @{ URL32 = $url; Version = $version }
	return $Latest
}

update -ChecksumFor none -NoCheckChocoVersion
