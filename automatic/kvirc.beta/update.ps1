$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://nightly.kvirc.net/win-x86_64/'

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
	$url32 = "https://nightly.kvirc.net$((Invoke-WebRequest -Uri $releases).Links.href | Where-Object {$_ -match ".exe$"} | select-object -Last 1)"
	#$version = $url32 -split '-' | Where-Object {$_ -match '[0-9]\.[0-9]'}
	#$version = "$version-dev"
	$version = ($url32 -split '/' | Select-Object -Last 1).replace('KVIrc-','').replace('.exe','')
	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update 