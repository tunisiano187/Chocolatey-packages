$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = "https://www.xiles.app/"

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
	$File = "$env:TEMP/chocolatey/nexusfile.install.html"
	Invoke-WebRequest -Uri $releases -OutFile $File
	$pageContent = Get-Content $File
	$url = "https://s3.ap-northeast-2.amazonaws.com/net.xiles.public/download/$(($pageContent | Where-Object {$_ -match "file"} | Where-Object {$_ -match "_setup_"} | Where-Object {$_ -match "exe"}).split("'") | Where-Object {$_ -match "_setup_"} | Where-Object {$_ -notmatch "beta"} | Select-Object -First 1)"

	$version = Get-Version $url
	#$checksumType = "SHA512"
	#$checksum = Get-RemoteChecksum -Url $url -Algorithm $checksumType

	$Latest = @{ URL32 = $url; Version = $version}
	return $Latest
}

update -ChecksumFor 32
