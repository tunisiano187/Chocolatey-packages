import-module au

$releases = 'https://sourceforge.net/projects/freeplane/files/freeplane%20stable/'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
		}
		'.\tools\VERIFICATION.txt' = @{
			"(?i)(\s+x32:).*"                   = "`${1} $($Latest.URL32)"
			"(?i)(Get-RemoteChecksum).*"        = "`${1} $($Latest.URL32)"
			"(?i)(\s+checksum32:).*"            = "`${1} $($Latest.Checksum32)"
		}
	}
}

function global:au_BeforeUpdate {
	Get-RemoteFiles -Purge -NoSuffix
	Invoke-WebRequest -Uri "https://raw.githubusercontent.com/freeplane/freeplane/1.11.x/license.txt" .\tools\LICENSE.txt
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$url32 = ((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match '-Setup-with'} | Where-Object {$_ -match '.exe'} | Where-Object {$_ -match "https"}).href | Select-Object -First 1
	$version = ($url32.Split('-|/') | Where-Object {$_ -match ".exe"}).replace('.exe','').replace('u','-u')
	if($version -eq "1.11.12") {
		$version = "1.11.12.202442901"
	}

	$Latest = @{ URL32 = $url32; Version = $version; FileName32 = "Freeplane.exe"; CorrettoVersion = $CorrettoVersion }
	return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion
