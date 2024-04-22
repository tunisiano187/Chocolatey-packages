import-module au

$releases = 'https://ramensoftware.com/downloads/7tt_setup.exe'


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
    $url32 = $releases

	$File = "$($env:TEMP)\7tt_setup.exe"
	Invoke-WebRequest -Uri $url32 -OutFile $File
    $version = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion

    return @{ URL32 = $url32; Version = $version }
}

update -ChecksumFor 32
