import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$release = 'https://www.softpointer.com/AudioShell.htm'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_BeforeUpdate {
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $Latest.URL32
	$Latest.Checksum32 = $FileVersion.Checksum
	$Latest.ChecksumType32 = $FileVersion.checksumType
}

function global:au_AfterUpdate($Package) {
  Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$page = Invoke-WebRequest -Uri $release -UseBasicParsing
	$regexPattern = '<h2>AudioShell (\d+(\.\d+)*)'
	$versionMatch = $page.Content | Select-String -Pattern $regexPattern -AllMatches
	$version = $versionMatch.Matches[0].Groups[1].Value
	if($version -eq '2.3.6') {
		$version = "2.3.6.20240921"
	}
	$url32 = "https://www.softpointer.com/$(($page.Links | Where-Object {$_.href -match 'exe$'} | Select-Object -First 1).href)"

  	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor none -NoCheckChocoVersion
