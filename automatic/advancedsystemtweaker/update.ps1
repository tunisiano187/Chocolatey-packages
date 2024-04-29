import-module au

$releases   = 'https://www.tweaking.com/features/advanced-system-tweaker/'

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

    $url = $download_page.Links.href | Where-Object {$_ -match "exe$"} | Select-Object -First 1
    $File = Join-Path $env:TEMP $($urls -split "/" | Select-Object -Last 1)
    Invoke-WebRequest -Uri $url -OutFile $File

    $version=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion

    return @{
        URL32 = $url
        Version = $version
    }
}

update
