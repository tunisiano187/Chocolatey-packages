$ErrorActionPreference = 'Stop'
import-module au

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

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$folder = ((Invoke-WebRequest -Uri $releases).Links | Where-Object {$_ -match 'v[0-9].'} | Select-Object -Last 1).href
	$file = ((Invoke-WebRequest -Uri "$releases$folder" ).Links | Where-Object {$_ -match ".msi"} | Select-Object -Last 1).href
	$url = "https://www.paraview.org/paraview-downloads/download.php?submit=Download&version=$folder&type=binary&os=Windows&downloadFile=$file"
	[version]$version=$folder.replace('v','').replace('/','')

	$Latest = @{ URL32 = $url; Version = $version }
	return $Latest
}

update -ChecksumFor 32