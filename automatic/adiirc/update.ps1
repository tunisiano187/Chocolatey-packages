import-module au

$domain     = 'https://www.adiirc.com'
$releases   = 'https://www.adiirc.com/download.php'

function global:au_SearchReplace {
  @{
    "tools\chocolateyInstall.ps1" = @{
      "(^[$]url\s*=\s*)('.*')"              = "`$1'$($Latest.URL32)'"
      "(^[$]url64\s*=\s*)('.*')"            = "`$1'$($Latest.URL64)'"
      "(^[$]checksum\s*=\s*)('.*')"         = "`$1'$($Latest.Checksum32)'"
      "(^[$]checksum64\s*=\s*)('.*')"       = "`$1'$($Latest.Checksum64)'"
      "(^[$]checksumType\s*=\s*)('.*')"     = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}


function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases

    $urls = $download_page.Links.href | Where-Object {$_ -match "exe$"} | Select-Object -First 2
    $url64 = $urls | Where-Object {$_ -match "64"}
    $url = $urls | Where-Object {$_ -notmatch $url64}

	  $version = (Get-Version ($download_page.Links.href | Where-Object {$_ -match "download.php\?v="} | Select-Object -First 1)).Version

    return @{
        URL32 = $domain + $url
        URL64 = $domain + $url64
        Version = $version
    }
}

try {
	update
} catch {
	$ignore = '403 (Forbidden)'
	if ($_ -match $ignore) { Write-Output $_; 'ignore' } else { throw $_ }
}
