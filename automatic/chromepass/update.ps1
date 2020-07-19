import-module au

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
			"(^[$]referer\s*=\s*)('.*')" = "`$1'$($Latest.Referer)'"
		}
	}
}

function global:au_GetLatest {
	$referer = "http://www.nirsoft.net/utils/chromepass.html"
	$url32 = 'http://www.nirsoft.net/toolsdownload/chromepass.zip'

	$zipFile = "$(Get-Location)/chomepass.zip"
	$toolsDir = Get-Location

	$wc = New-Object System.Net.WebClient
	$wc.Headers.Add("Referer", $referer)
	$wc.DownloadFile($url32, $zipFile)

	$7ZipPath = "$env:ProgramData\chocolatey\tools\7z.exe"
	$zipFilePassword = "chpass9126*"
	$command = "& $7ZipPath e -o$toolsDir -y -tzip -p$zipFilePassword $zipFile"
	Invoke-Expression $command

	$File = "$toolsDir/ChromePass.exe"

	$version=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion

	$Latest = @{ URL32 = $url32; Referer = $referer; Version = $version }
	return $Latest
}

update -ChecksumFor 32