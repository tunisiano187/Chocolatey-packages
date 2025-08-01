import-module chocolatey-AU

$releases = 'https://sourceforge.net/projects/freepascal/rss?path=/Win32'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]Url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
			"(^[$]Url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
			"(^[$]checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$File = "$env:TEMP\freepascal.xml"
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
