import-module au

$releases 		= 'http://bit.ly/getAndy'
$checksumType32 = 'sha256'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumtype\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_GetLatest {
	$url32 = $releases
	$File = Join-Path($(Split-Path $script:MyInvocation.MyCommand.Path)) "andy.exe"
	Invoke-WebRequest -Uri $url32 -OutFile $File
	$version=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion.trim()
	$checksum32 = $(Get-FileHash -Algorithm $checksumType32 $File).Hash

	$Latest = @{ URL32 = $url32; Checksum32 = $checksum32; ChecksumType32 = $checksumType32; Version = $version }
	return $Latest
}

update -ChecksumFor none