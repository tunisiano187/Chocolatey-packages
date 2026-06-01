import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$releases = 'https://sourceforge.net/projects/freeplane/rss?path=/freeplane%20stable'

function global:au_SearchReplace {
	@{
		'.\legal\VERIFICATION.txt' = @{
			"(?i)(\s+x32:).*"                   = "`${1} $($Latest.URL32)"
			"(?i)(Get-RemoteChecksum).*"        = "`${1} $($Latest.URL32)"
			"(?i)(\s+checksum32:).*"            = "`${1} $($Latest.Checksum32)"
		}
	}
}

function global:au_BeforeUpdate {
	Invoke-WebRequest -Uri "https://raw.githubusercontent.com/freeplane/freeplane/1.12.x/license.txt" -OutFile "legal\LICENSE.txt"
	# SourceForge URLs end with /download; extract the actual .exe filename from the second-to-last path segment
	$urlSegments = ([uri]$Latest.URL32).AbsolutePath -split '/' | Where-Object { $_ }
	$cleanFileName = if ($urlSegments[-1] -eq 'download') {
		[uri]::UnescapeDataString($urlSegments[-2])
	} else {
		[System.IO.Path]::GetFileName(([uri]$Latest.URL32).LocalPath)
	}
	$destPath = "tools\$cleanFileName"
	Invoke-WebRequest -Uri $Latest.URL32 -OutFile $destPath -UseBasicParsing
	$Latest.Checksum32 = (Get-FileHash -Path $destPath -Algorithm SHA512).Hash
	$Latest.ChecksumType32 = 'sha512'
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	[xml]$rss = Invoke-WebRequest -Uri $releases | Select-Object -ExpandProperty Content
	$items = $rss.rss.channel.item | Where-Object {
		($_.title -like "*-Setup-with*.exe*") -or ($_.link -like "*Freeplane-Setup*.exe*")
	} | Select-Object -First 1

	$url32 = $items.link
	$version = ($url32.Split('-|/') | Where-Object {$_ -match ".exe"}).replace('.exe','').replace('u','-u')

	if($version -eq "1.11.12") {
		$version = "1.11.12.202442901"
	}

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor none
