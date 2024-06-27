import-module au

$releases = 'https://gcompris.net/downloads-fr.html#windows'

function global:au_SearchReplace {
	@{
		'.\legal\VERIFICATION.txt' = @{
			"(?i)(\s+x32:).*"                   = "`${1} $($Latest.URL32)"
			"(?i)(Get-RemoteChecksum).*"        = "`${1} $($Latest.URL32)"
			"(?i)(\s+checksum32:).*"            = "`${1} $($Latest.Checksum32)"
			"(?i)(\s+ChecksumType:).*"          = "`${1} $($Latest.ChecksumType32)"
			"(?i)(\s+x64:).*"                   = "`${1} $($Latest.URL64)"
			"(?i)(\s+checksum64:).*"            = "`${1} $($Latest.Checksum64)"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$urls = ((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_.href -match "-gcc.exe$"}).href
	$url32 = $urls | Where-Object {$_ -match "32"}
	$url64 = $urls | Where-Object {$_ -match "64"}
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion32 = Get-FileVersion $url32 -keep
	$FileVersion64 = Get-FileVersion $url64 -keep
	
	Move-Item -Path $FileVersion32.TempFile -Destination 'tools/gcompris-qt-win32-gcc.exe'
	Move-Item -Path $FileVersion64.TempFile -Destination 'tools/gcompris-qt-win64-gcc.exe'
	
	$Latest = @{ URL32 = $url32; Checksum32 = $FileVersion32.CHECKSUM; ChecksumType32 = $FileVersion32.ChecksumType; URL64 = $url64; Checksum64 = $FileVersion64.CHECKSUM; ChecksumType64 = $FileVersion64.ChecksumType; Version = $version }
	return $Latest
}

update -ChecksumFor none