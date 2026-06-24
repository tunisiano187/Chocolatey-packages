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

	# Use regex on Content (works in both Windows PS 5.1 and PS Core Where-Object .Links may be null)
	$folderMatches = [regex]::Matches($webResponse.Content, 'href="(v(\d+)\.(\d+)/)"')
	if (-not $folderMatches.Count) {
		throw "Could not find version folder links on $releases"
	}

	# Sort numerically to get the true latest (avoids lexicographic ordering issues like v5.9 > v5.10)
	$latestFolder = $folderMatches | Sort-Object {
		[int]$_.Groups[2].Value * 1000 + [int]$_.Groups[3].Value
	} | Select-Object -Last 1

	$folder = $latestFolder.Groups[1].Value  # e.g., "v6.1/"

	$fileResponse = Invoke-WebRequest -Uri "$releases$folder" -UseBasicParsing

	# Match non-MPI Windows AMD64 MSI specifically
	$fileMatches = [regex]::Matches($fileResponse.Content, 'href="(ParaView-[\d.]+-Windows-[^"]+\.msi)"')
	if (-not $fileMatches.Count) {
		throw "Could not find Windows MSI file link in $releases$folder"
	}

	$file = ($fileMatches | Select-Object -Last 1).Groups[1].Value
	$version = ($file -split '-')[1]
	$url = "https://www.paraview.org/paraview-downloads/download.php?submit=Download&version=$folder&type=binary&os=Windows&downloadFile=$file"

	return @{ URL32 = $url; Version = $version }
}

update -ChecksumFor none -NoCheckChocoVersion
