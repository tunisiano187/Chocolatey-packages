import-module au

$releases = 'https://lulzbot.com/support/cura-windows'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1" = @{
            "(^[$]url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $regex = '.exe$'
    $url = $download_page.links | ? href -match $regex | select -First 1 -expand href

    $version = $url.Split('/')[-1].split('-') | Where-Object {$_ -NotMatch 'Win'} | Where-Object {$_ -match '\.'}

    @{
        URL32 = $url
        Version = $version
    }
}

update -ChecksumFor 32 -NoCheckChocoVersion
