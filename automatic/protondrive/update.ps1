import-module au

$releases = "https://proton.me/download/drive/windows/version.json"

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
	$tempFile = New-TemporaryFile
	Invoke-WebRequest -Uri $releases -OutFile $tempFile
	$page = Get-Content $tempFile
	$url32 = ($page | Where-Object {$_ -match ".exe"} | Select-Object -First 1).split('"')[-2]
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $url32

	$Latest = @{ URL32 = $url32; Version = $version; Checksum32 = $FileVersion.Checksum; ChecksumType32 = $FileVersion.ChecksumType }
	return $Latest
}

update -ChecksumFor none