import-module au

$release = 'https://blink.sipthor.net/download.phtml?download&os=nt'


function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
			"(^[$]referer\s*=\s*)('.*')" 		= "`$1'$($Latest.Referer)'"
		}
	}
}

function global:au_GetLatest {
	#$referer        = 'http://icanblink.com/download/'
	#Invoke-WebRequest -Uri $referer -OutFile "$env:TEMP/icanblink.html" -UseBasicParsing #  Required to be allowed just after
	$url32 = $release
	$File = Join-Path($(Split-Path $script:MyInvocation.MyCommand.Path)) "blink.exe"
	#Invoke-WebRequest -Uri $url32 -OutFile $File -UseBasicParsing
	Import-Module BitsTransfer
	Start-BitsTransfer -Source $url32 -Destination $File
	$version=$(Get-Command $File).FileVersionInfo.ProductVersion.trim()

	$Latest = @{ URL32 = $url32; Version = $version; Referer = $referer }
	return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion