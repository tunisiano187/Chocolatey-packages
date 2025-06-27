import-module au

$releases = 'https://www.arduino.cc/en/software'


function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"            = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')"       = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')"   = "`$1'$($Latest.ChecksumType32)'"
		}
	}
}



function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
    $url32 = $(((((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links)) | Where-Object {$_ -match 'windows'}  | Where-Object {$_ -match '.exe'} | Select-Object -First 1).href)

    $version = $url32 -split '_' | Select-Object -First 1 -Skip 1

    return @{ URL32 = $url32; Version = $version }
}

update -ChecksumFor 32
