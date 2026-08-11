$ErrorActionPreference = 'Stop'
Import-Module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$wingetPkgPath = 'manifests/p/Perplexity/Perplexity'

function global:au_SearchReplace {
    @{
        'tools/chocolateyInstall.ps1' = @{
            "(?i)(^\s*\`$url64bit\s*=\s*)'[^']*'"       = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*\`$checksum64\s*=\s*)'[^']*'"      = "`$1'$($Latest.Checksum64)'"
            "(?i)(^\s*\`$checksumType64\s*=\s*)'[^']*'"  = "`$1'$($Latest.ChecksumType64)'"
        }
    }
}

function global:au_AfterUpdate($Package) {
    Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
    $headers = @{ 'User-Agent' = 'AU-Updater' }
    if ($env:github_api_key) { $headers['Authorization'] = "token $env:github_api_key" }

    # Get latest version from winget-pkgs manifests
    $apiUrl = "https://api.github.com/repos/microsoft/winget-pkgs/contents/$wingetPkgPath"
    $dirs = Invoke-RestMethod $apiUrl -Headers $headers | Where-Object { $_.type -eq 'dir' }
    $latestVersion = ($dirs | Sort-Object { [System.Version]$_.name } -Descending | Select-Object -First 1).name

    # Fetch the installer YAML for the latest version
    $yamlUrl = "https://raw.githubusercontent.com/microsoft/winget-pkgs/master/$wingetPkgPath/$latestVersion/Perplexity.Perplexity.installer.yaml"
    $yaml = (Invoke-WebRequest $yamlUrl -UseBasicParsing -Headers $headers).Content

    # Extract x64 installer URL (matches lines containing 'x64' in the URL)
    $url64 = ([regex]::Matches($yaml, 'InstallerUrl:\s*(https://[^\r\n]+x64[^\r\n]*)') |
        Select-Object -First 1).Groups[1].Value.Trim()

    Update-Metadata -key 'releaseNotes' -value 'https://www.perplexity.ai/changelog'

    return @{
        URL64   = $url64
        Version = $latestVersion
    }
}

update -ChecksumFor 64
