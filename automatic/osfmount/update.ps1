$ErrorActionPreference = 'Stop'
import-module au

function global:au_SearchReplace {
	@{
		"legal\VERIFICATION.txt"      = @{
			"(?i)(x86:).*"        				= "`${1} $($Latest.URL32)"
			"(?i)(checksum:).*" 				= "`${1} $($Latest.Checksum32)"
			"(?i)(checksumtype:).*" 			= "`${1} $($Latest.ChecksumType32)"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$url32 = "https://www.osforensics.com/downloads/osfmount.exe"
	$FileInfos = Get-FileVersion $url32 -keep
	Move-Item -Path $FileInfos.TempFile -Destination "tools\osfmount.exe"
	
	$Latest = @{ URL32 = $url32; Checksum32 = $FileInfos.CHECKSUM; ChecksumType32 = $FileInfos.ChecksumType; Version = $FileInfos.Version }
	return $Latest
}

update -NoCheckUrl -ChecksumFor none
