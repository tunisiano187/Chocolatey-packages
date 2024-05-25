$ErrorActionPreference = 'Stop'
import-module au

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
    $page = (Invoke-WebRequest -Uri $releases).Content
    $regex = 'dl\.php\?id=\d+'
    $matches = [regex]::Matches($page , $regex)
    if ($matches.Count -gt 0) {
        $downloadUrl = $matches[0].Value
    }
    $url = Get-RedirectedUrl "https://xstreamloader.techweb.at/$($downloadUrl)"

    return @{ URL32 = $url; Version = $version }
}

update-package