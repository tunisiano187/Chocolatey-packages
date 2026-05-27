$ErrorActionPreference = 'Stop'
Import-Module chocolatey-AU

$baseUrl = 'https://download.silicondust.com/hdhomerun/hdhomerun_windows.exe'

function global:au_AfterUpdate($Package) {
    . ..\..\scripts\Invoke-VirusTotalScan.ps1
    Invoke-VirusTotalScan $Package
}

function global:au_SearchReplace {
    @{
        'tools/chocolateyInstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
    }
}

function global:au_GetLatest {
    # Follow the redirect once to obtain the versioned filename
    # e.g. hdhomerun_windows.exe -> hdhomerun_windows_20260326.exe
    # Note: in .NET Framework (PS 5.1), GetResponse() throws WebException for 3xx;
    # the Location header is on the exception's Response object. In .NET Core (PS 7+)
    # it returns the redirect response directly. Handle both.
    $redirectUrl = $null
    try {
        $req = [System.Net.HttpWebRequest]::Create($baseUrl)
        $req.Method = 'HEAD'
        $req.AllowAutoRedirect = $false
        $resp = $req.GetResponse()
        $redirectUrl = $resp.Headers['Location']
        $resp.Close()
    } catch [System.Net.WebException] {
        $exResp = $_.Exception.Response
        if ($exResp) {
            $redirectUrl = $exResp.Headers['Location']
            $exResp.Close()
        }
    }

    if (!$redirectUrl) {
        throw "No redirect from $baseUrl — cannot determine version"
    }

    # Parse date from versioned filename: hdhomerun_windows_YYYYMMDD.exe
    if ($redirectUrl -notmatch 'hdhomerun_windows_(\d{4})(\d{2})(\d{2})\.exe') {
        throw "Cannot parse version from redirect URL: $redirectUrl"
    }
    $version = "$($Matches[1]).$($Matches[2]).$($Matches[3])"

    . ..\..\scripts\Get-FileVersion.ps1
    $FileVersion = Get-FileVersion $redirectUrl

    return @{
        URL32          = $redirectUrl
        Version        = $version
        Checksum32     = $FileVersion.Checksum
        ChecksumType32 = $FileVersion.ChecksumType
    }
}

update -ChecksumFor none
