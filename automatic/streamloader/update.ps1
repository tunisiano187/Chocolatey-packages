$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'https://xstreamloader.techweb.at/en/download.html'

function global:au_SearchReplace {
    @{
        'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
		}
    }
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
    $page = (Invoke-WebRequest -Uri $releases -UseBasicParsing).Content
    $regex = 'dl\.php\?id=\d+'
    $matches = [regex]::Matches($page , $regex)
    if ($matches.Count -gt 0) {
        $downloadUrl = $matches[0].Value
    }
    $url = Get-RedirectedUrl "https://xstreamloader.techweb.at/$($downloadUrl)"
    $File = (Join-Path $env:TEMP "chocolatey\$($url.Split('/')[-1])").Replace('.zip','.rar')
    $Folder = Join-Path $env:TEMP "chocolatey\streamloader\"
    Invoke-WebRequest -Uri $url -OutFile $File -UseBasicParsing
    $parameter = @('x', "$File", "-o$Folder", "-y")
    7z @parameter
    $File = Join-Path $Folder "X-StreamLoader.exe"
    $version = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion

    return @{ URL32 = $url; Version = $version }
}

update-package
