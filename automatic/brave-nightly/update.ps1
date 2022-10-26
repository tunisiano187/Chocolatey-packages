$ErrorActionPreference = 'Stop'
import-module au

# $releases = 'https://github.com/brave/brave-browser/releases'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url32\s*=\s*)('.*')"		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum32\s*=\s*)('.*')"	= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType32\s*=\s*)('.*')"	= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}
function global:au_GetLatest {
	Write-Verbose 'Get files'
	$tags = Invoke-WebRequest 'https://api.github.com/repos/brave/brave-browser/releases' -UseBasicParsing | ConvertFrom-Json
	$url32 = ($tags[0].assets | Where-Object {$_.browser_download_url -match ".exe$"}).browser_download_url | Where-Object { $_ -match 'StandaloneSilent'} | Where-Object {$_ -notmatch '32.exe'} | Where-Object {$_ -notmatch 'Arm64'}

	Write-Verbose 'Checking version'
	$version=($tags[0].name.Split(' ')[1]).replace('v','')

	if($tags[0].prerelease -eq $true) {
		$version = "$version-nightly"
	} elseif ($url32 -match 'Nightly') {
		$version = "$version-nightly"
	} else {
		$version = '0.0'
	}
	Write-Output "Version : $version"

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32
