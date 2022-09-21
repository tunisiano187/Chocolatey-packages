$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://github.com/iBotPeaches/Apktool/releases'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      			= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 			= "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumtype\s*=\s*)('.*')" 		= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_GetLatest {
	Write-Verbose 'Get files'
	$tags = Invoke-WebRequest 'https://api.github.com/repos/iBotPeaches/Apktool/releases' -UseBasicParsing | ConvertFrom-Json
	$url32 = ($tags[0].assets | where {$_.browser_download_url -match ".jar"}).browser_download_url
	
	Write-Verbose 'Checking version'
	$version=$tags[0].name.Split(' ')[-1].replace('v','')
	
	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion
