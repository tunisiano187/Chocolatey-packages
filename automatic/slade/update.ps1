import-module chocolatey-AU

$releases = 'https://slade.mancubus.net/index.php?page=downloads'

function global:au_SearchReplace {
   @{
        "tools\chocolateyInstall.ps1" = @{
            "(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
        }
    }
}

function global:au_AfterUpdate($Package) {
	. ..\..\scripts\Invoke-VirusTotalScan.ps1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    # Filter to absolute GitHub release URLs only to avoid concatenating relative + absolute hrefs
    $urls = $page.Links |
        Where-Object { $_.href -match '\.7z' } |
        Where-Object { $_.href -notmatch 'winxp|tools|beta' } |
        Where-Object { $_.href -match 'github\.com' } |
        Select-Object -ExpandProperty href -Unique
    # Package ships 64-bit only; URL32 slot is used for the x64 archive
    $url64 = $urls | Where-Object { $_ -match 'x64' } | Select-Object -First 1
    $version = (Get-Version $url64).Version
    @{
        Version      = $version
        URL32        = $url64
    }
}

update
