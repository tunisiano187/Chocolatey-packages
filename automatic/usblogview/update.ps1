import-module au

$releases = "https://www.nirsoft.net/utils/usb_log_view.html"

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
     }
}

function global:au_GetLatest {
	$download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

	$url32 = "https://www.nirsoft.net/utils/usblogview.zip"

	$version = $download_page.Content.Split(" v").split("<br>") | Where-Object {$_ -match "[0-9]\.[0-9][0-9]"} | Select-Object -First 1

	$Latest = @{ URL32 = $url32; Version = $version }
    return $Latest
}

update -ChecksumFor 32