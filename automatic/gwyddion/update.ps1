import-module chocolatey-AU

$releases = 'https://sourceforge.net/projects/gwyddion/rss?path=/gwyddion'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      			= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 			= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 		= "`$1'$($Latest.ChecksumType32)'"
			"(^[$]url64\s*=\s*)('.*')"      		= "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum64)'"
		}
	}
}

function global:au_BeforeUpdate {
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $Latest.URL32
	$Latest.Checksum32 = $FileVersion.Checksum
	$Latest.ChecksumType32 = $FileVersion.checksumType
	$FileVersion = Get-FileVersion $Latest.URL64
	$Latest.Checksum64 = $FileVersion.Checksum
	$Latest.ChecksumType64 = $FileVersion.checksumType
}

function global:au_AfterUpdate($Package) {
	Import-Module ..\..\scripts\au_extensions.psm1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	[xml]$xml = Invoke-WebRequest -Uri $releases

	# Chercher le premier élément <link> qui contient '-win32.exe'
	$linkNode = $xml.rss.channel.item | Where-Object { $_.link -match '.win32.exe' } | Select-Object -First 1

	# Extraire l'URL
	$url32 = $linkNode.link
	$linkNode = $xml.rss.channel.item | Where-Object { $_.link -match '.win64.exe' } | Select-Object -First 1

	# Extraire l'URL
	$url64 = $linkNode.link

	$version = (Get-Version $url32).Version

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

update -NoCheckChocoVersion -ChecksumFor none
