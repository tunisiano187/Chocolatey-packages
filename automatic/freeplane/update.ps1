import-module au

$releases = 'https://sourceforge.net/projects/freeplane/files/freeplane%20stable/'
$bugversion = "1.11.13"

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
		}
		"$($Latest.PackageName).nuspec" = @{
			"(\<dependency .+?`"corretto11jdk`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.CorrettoVersion)]`""
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$url32 = ((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match '-Setup-'} | Where-Object {$_ -match '.exe'} | Where-Object {$_ -match "https"}).href | Select-Object -First 1
	$version = ($url32.Split('-|/') | Where-Object {$_ -match ".exe"}).replace('.exe','').replace('u','-u')
	
	$version = Get-FixVersion -Version $version -OnlyFixBelowVersion $bugversion
	$CorrettoVersion = $(choco search corretto11jdk | Where-Object {$_ -match 'corretto11jdk'}).split(' ')[1]

	$Latest = @{ URL32 = $url32; Version = $version; FileName32 = "Freeplane.exe"; CorrettoVersion = $CorrettoVersion }
	return $Latest
}

update -ChecksumFor 32
