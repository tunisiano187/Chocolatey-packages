import-module au

$url32 = 'https://www.nirsoft.net/utils/wakemeonlan.zip'
$url64 = 'https://www.nirsoft.net/utils/wakemeonlan-x64.zip'


Add-Type -AssemblyName System.IO.Compression.FileSystem
function Unzip
{
    param([string]$zipfile, [string]$outpath)
    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
}

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
			"(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
			"(^[$]checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
		}
	}
}

function global:au_GetLatest {
	$File = "./usblogview.zip"
	Invoke-WebRequest -Uri $url32 -OutFile $File -UseBasicParsing
	Expand-Archive $File -DestinationPath .\wol

	$version=$(Get-Content .\wol\readme.txt | Where-Object {$_ -match 'WakeMeOnLan'})[0].split(' ')[-1].Replace('v','')

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update