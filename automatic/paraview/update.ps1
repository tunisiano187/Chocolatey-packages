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

	# Sort numerically newest-first (avoids lexicographic ordering issues like v5.9 > v5.10)
	$foldersNewestFirst = $folderMatches | Sort-Object -Descending {
		[int]$_.Groups[2].Value * 1000 + [int]$_.Groups[3].Value
	}

	# The regex below deliberately requires "-Windows-" right after the version digits, so it
	# already excludes "-RC1-Windows-..." release-candidate filenames -- but a brand-new folder
	# (e.g. v6.2) can exist on the server with ONLY an RC build published and no stable release
	# yet. That used to throw outright. Walk folders newest-first and skip any that don't have a
	# genuine stable Windows MSI, falling back to the previous stable folder instead. Confirmed
	# live: v6.2/ currently contains only "ParaView-6.2.0-RC1-Windows-...msi".
	$file = $null
	foreach ($f in $foldersNewestFirst) {
		$folder = $f.Groups[1].Value  # e.g., "v6.1/"
		$fileResponse = Invoke-WebRequest -Uri "$releases$folder" -UseBasicParsing
		# Match non-MPI Windows AMD64 MSI specifically
		$fileMatches = [regex]::Matches($fileResponse.Content, 'href="(ParaView-[\d.]+-Windows-[^"]+\.msi)"')
		if ($fileMatches.Count) {
			$file = ($fileMatches | Select-Object -Last 1).Groups[1].Value
			break
		}
	}
	if (-not $file) {
		throw "Could not find a stable Windows MSI file link in any version folder on $releases"
	}

	$version = ($file -split '-')[1]
	$url = "https://www.paraview.org/paraview-downloads/download.php?submit=Download&version=$folder&type=binary&os=Windows&downloadFile=$file"

	return @{ URL32 = $url; Version = $version }
}

update -ChecksumFor none
