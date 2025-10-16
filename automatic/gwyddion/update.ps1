import-module chocolatey-AU

$releases = 'https://sourceforge.net/projects/gwyddion/rss?path=/'

function global:au_SearchReplace {
	@{
		'.\legal\VERIFICATION.txt' = @{
			"(?i)(\s+x32:).*"                   = "`${1} $($Latest.URL32)"
			"(?i)(Get-RemoteChecksum).*"        = "`${1} $($Latest.URL32)"
			"(?i)(\s+checksum32:).*"            = "`${1} $($Latest.Checksum32)"
			"(?i)(\s+x64:).*"                   = "`${1} $($Latest.URL64)"
			"(?i)(\s+checksum64:).*"            = "`${1} $($Latest.Checksum64)"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	[xml]$xml = Invoke-WebRequest -Uri $releases

	# Chercher le premier élément <link> qui contient '-win32.exe'
	$linkNode = $xml.rss.channel.item | Where-Object { $_.link -match '-win32.exe' } | Select-Object -First 1

	# Extraire l'URL
	$url32 = $linkNode.link
	$linkNode = $xml.rss.channel.item | Where-Object { $_.link -match '-win64.exe' } | Select-Object -First 1

	# Extraire l'URL
	$url64 = $linkNode.link

	$version = (Get-Version $url32).Version

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

update -NoCheckChocoVersion
