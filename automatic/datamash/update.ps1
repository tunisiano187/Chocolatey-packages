import-module au

$releases = 'https://download.savannah.gnu.org/releases/datamash/windows-binaries/'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1" = @{
            "(^[$]url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
        "$($Latest.PackageName).nuspec" = @{
			"(\<copyright\>).*?(\</copyright\>)" 	= "`${1}© $((Get-Date).year) Assaf Gordon`$2"
		}
    }
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $regex  = '.exe$'
    $url    = ($download_page.links | Where-Object href -match $regex).href | Sort-Object -Descending
    $url32  = "https://download.savannah.gnu.org/releases/datamash/windows-binaries/$($url | Where-Object {$_ -match "32bit.exe"} | Select-Object -First 1)"
    $url64  = "https://download.savannah.gnu.org/releases/datamash/windows-binaries/$($url | Where-Object {$_ -match "64bit.exe"} | Select-Object -First 1)"

    $version = $url32.Split('-') | Where-Object {$_ -Match '\.'} | Where-Object {$_ -notmatch ".exe$"} | Where-Object {$_ -notmatch "http"}

    @{
        URL32   = $url32
        URL64   = $url64
        Version = $version
    }
}

update