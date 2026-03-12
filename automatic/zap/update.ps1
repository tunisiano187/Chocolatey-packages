# Update script for zap package
import-module chocolatey-AU
function global:au_SearchReplace {
    @{
        "$($Latest.PackageName)\tools\chocolateyInstall.ps1" = @{
            "(?<=^[$]packageVer\s*=\s*).*" = "$($Latest.Version)"
            "(?<=^[$]url\s*=\s*['""]).*(?=['""])" = "$($Latest.URL32)"
            "(?<=^[$]checksum\s*=\s*['""]).*(?=['""])" = "$($Latest.Checksum32)"
            "(?<=^[$]url64\s*=\s*['""]).*(?=['""])" = "$($Latest.URL64)"
            "(?<=^[$]checksum64\s*=\s*['""]).*(?=['""])" = "$($Latest.Checksum64)"
        }
    }
}
function global:au_GetLatest {
    $downloadPage = Invoke-WebRequest -Uri 'https://www.zaproxy.org/download/'
    $versionMatch = $downloadPage.Content -match 'ZAP_([\d\.]+)\.zip'
    if (!$versionMatch) { throw "Cannot find version" }
    $version = $matches[1]
    $url32 = "https://github.com/zaproxy/zaproxy/releases/download/v$version/ZAP_${version}_Windows.zip"
    $url64 = $url32
    $checksumType = 'sha256'
    $checksumUrl = "https://github.com/zaproxy/zaproxy/releases/download/v$version/ZAP_${version}_Windows.zip.sha256"
    $checksum = Invoke-WebRequest -Uri $checksumUrl -UseBasicParsing | Select-Object -Expand Content
    return @{
        Version      = $version
        URL32        = $url32
        URL64        = $url64
        Checksum32   = $checksum
        Checksum64   = $checksum
        PackageName  = 'zap'
    }
}
update -ChecksumFor none
