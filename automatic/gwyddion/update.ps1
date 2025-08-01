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
	$File = "$env:TEMP\gwyddion.xml"
	Invoke-WebRequest -Uri $releases -OutFile $File
	$xml = Get-Content $File
	$links=$xml | Where-Object {$_ -match '-win32.exe'} | Where-Object {$_ -match 'link'}  | Select-Object -First 1
	$url32 = $links.Split('<|>') | Where-Object {$_ -match 'win32.exe'}
	$links=$xml | Where-Object {$_ -match 'win64.exe'} | Where-Object {$_ -match 'link'}  | Select-Object -First 1
	$url64 = $links.Split('<|>') | Where-Object {$_ -match 'win64.exe'}
	$version = (Get-Version $url32).Version

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

update -NoCheckChocoVersion
