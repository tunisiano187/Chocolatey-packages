import-module au

$releases = "https://www.binisoft.org/wfc"

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32Type)'"
        }
     }
}

function global:au_GetLatest {
	$download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

	$re  = "setup.exe"
	$url32 = $download_page.links | Where-Object href -match $re | Select-Object -First 1 -expand href

    $File = Join-Path($(Split-Path $script:MyInvocation.MyCommand.Path)) "wfcsetup.exe"
	Invoke-WebRequest -Uri $url32 -OutFile $File
	$version=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion.trim()

	$Latest = @{ URL32 = $url32; Version = $version }
    return $Latest
}

update -ChecksumFor 32