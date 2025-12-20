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
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $urls = $page.Links | Where-Object { $_.href -match '.7z' } | Where-Object { $_.href -notmatch 'winxp|tools|beta' } | Select-Object -ExpandProperty href -Unique
    $url32 = "https://slade.mancubus.net/$($urls | Where-Object { $_ -notmatch 'x64' })"
    $url64 = "https://slade.mancubus.net/$($urls | Where-Object { $_ -match 'x64' })"
    $version = (Get-Version $url32).Version
    @{
        Version      = $version
        URL32        = $url64
    }
}

update
