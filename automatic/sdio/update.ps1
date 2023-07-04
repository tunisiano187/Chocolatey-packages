import-module au

$releases = 'https://www.glenn.delahoy.com/snappy-driver-installer-origin/'

function global:au_SearchReplace {
   @{
        "tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"                = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"           = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksumtype\s*=\s*)('.*')"           = "`$1'$($Latest.Checksum3Type2)'"
            "(?i)(^\s*.fileName32\s*=\s*)('.*')"        = "`$1'SDIO_R$($Latest.baseVersion).exe'"
            "(?i)(^\s*.fullVersion\s*=\s*)('.*')"       = "`$1'$($Latest.version)'"
            "(?i)(^\s*.SpecificFolder\s*=\s*)('.*')"    = "`$1'SDIO_$($Latest.version)'"
        }

        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"              = "`${1} $($Latest.URL32)"
          "(?i)(checksum32:).*"          = "`${1} $($Latest.Checksum32)"
          "(?i)(Get-RemoteChecksum32).*" = "`${1} $($Latest.URL32)"
        }
    }
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_AfterUpdate  {
    $baseVersion = $Latest.baseVersion

    Remove-Item ".\*.nupkg"
    New-Item ".\tools\SDIO_R${baseVersion}" -ItemType Directory
    New-Item ".\tools\SDIO_R${baseVersion}\SDIO_R${baseVersion}.exe.gui" -ItemType file
    New-Item ".\tools\SDIO_R${baseVersion}\SDIO_x64_R${baseVersion}.exe.gui" -ItemType file
}

function global:au_BeforeUpdate {
    Remove-Item ".\tools\SDIO_R*" -Force -Recurse
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases
    $url32 = "https://www.glenn.delahoy.com$(($download_page.Links | Where-Object href -match '.zip' | Select-Object -First 1).href)"
    $version = [regex]::match($url32, '[a-zA-Z_]*([\d\.]*)\.zip').Groups[1].Value # 0.6.0.558
    $baseVersion = $version.split('.')[-1] # 558
    @{
        Version      = $version
        baseVersion  = $baseVersion
        URL32        = $url32
    }
}

try {
    update -ChecksumFor 32
} catch {
    $ignore = "Unable to connect to the remote server"
    if ($_ -match $ignore) { Write-Output $ignore; 'ignore' } else { throw $_ }
}
