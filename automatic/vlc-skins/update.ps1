$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://www.videolan.org/vlc/skins2/vlc-skins.zip'

function global:au_SearchReplace {
	@{
		"legal\VERIFICATION.txt" = @{
			"(url32+:).*"  			= "`${1} $($Latest.URL32)"
			"(checksum32+:).*" 		= "`${1} $($Latest.Checksum32)"
			"(checksumtype+:).*" 	= "`${1} $($Latest.ChecksumType32)"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	. ..\..\scripts\Get-FileVersion.ps1
	$FileInfos = Get-FileVersion -url $releases -keep
	$fileContent = Get-Content -Path '.\legal\VERIFICATION.txt'
	if ($fileContent -match $FileInfos.checksum) {
		Write-Debug "Checksum $checksum match, won't be updating the file"
		$version = "0.0"
	} else {
		Move-Item -Path $FileInfos.TempFile -Destination "tools\$($FileInfos.FileName)"
		$response = Invoke-WebRequest -Uri $releases -Method Head
		$FileDate = [datetime]::Parse($response.Headers["Last-Modified"])
		$version = "{0:0000}.{1:00}.{2:00}" -f $FileDate.Year, $FileDate.Month, $FileDate.Day
	}

	$Latest = @{ URL32 = $releases; Version = $version; Checksum32 = $FileInfos.CHECKSUM; ChecksumType32 = $FileInfos.ChecksumType }
	return $Latest
}

update -ChecksumFor none