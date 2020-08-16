$ErrorActionPreference = 'Stop'
import-module au

$releases 		= 'https://www.andyroid.net/getandy.php'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      			= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 			= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 		= "`$1'$($Latest.ChecksumType32)'"
			"(^[$]url64\s*=\s*)('.*')"      		= "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum64)'"
			"(^[$]checksumType64\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType64)'"
		}
	}
}

function global:au_GetLatest {
	$request = Invoke-WebRequest -Method Head -Uri $releases -UseBasicParsing
	if ($null -ne $request.BaseResponse.ResponseUri) {
		# This is for Powershell 5
		$url32 = $request.BaseResponse.ResponseUri.AbsoluteUri
	}
	elseif ($null -ne $request.BaseResponse.RequestMessage.RequestUri) {
		# This is for Powershell core
		$url32 = $request.BaseResponse.RequestMessage.RequestUri.AbsoluteUri
	}
	$url64 = $url32.replace('x86.exe', 'x64.exe')
	$separated = $url32.split('=')[-1].split('_')
	$version = "$($separated[1]).$($separated[2]).$($separated[3])"

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

update -ChecksumFor none -NoCheckChocoVersion
