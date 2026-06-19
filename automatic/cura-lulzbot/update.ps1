Import-Module chocolatey-AU

$baseUrl = 'https://software.lulzbot.com/Cura_LulzBot_Edition/Windows'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1" = @{
            "(^[$]url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_AfterUpdate($Package) {
    Import-Module ..\..\scripts\au_extensions.psm1
    Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
    $indexPage = Invoke-WebRequest -Uri "$baseUrl/" -UseBasicParsing

    # Get stable version folders only (X.Y.Z pattern, no BETA/alpha suffix in folder name)
    $versions = $indexPage.links |
        Select-Object -ExpandProperty href |
        Where-Object { $_ -match '^\d+\.\d+\.\d+/$' } |
        ForEach-Object { $_.TrimEnd('/') } |
        Sort-Object { [version]$_ } -Descending

    foreach ($ver in $versions) {
        $versionPage = Invoke-WebRequest -Uri "$baseUrl/$ver/" -UseBasicParsing

        # Find a stable .exe: exclude Exp, BETA, alpha, patched variants
        $exeHref = $versionPage.links |
            Select-Object -ExpandProperty href |
            Where-Object { $_ -match '\.exe$' } |
            Where-Object { $_ -notmatch 'Exp' } |
            Where-Object { $_ -notmatch 'BETA' } |
            Where-Object { $_ -notmatch 'alpha' } |
            Where-Object { $_ -notmatch 'patched' } |
            Select-Object -First 1

        if ($exeHref) {
            $url = if ($exeHref -match '^https?://') { $exeHref } else { "$baseUrl/$ver/$exeHref" }
            return @{
                URL32   = $url
                Version = $ver
            }
        }
    }

    throw "Could not find a stable Windows installer in $baseUrl"
}

update -ChecksumFor 32 -NoCheckChocoVersion
