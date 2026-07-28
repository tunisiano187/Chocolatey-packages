# Heavily based on <https://github.com/flcdrg/au-packages/blob/8c755c9fadb4c03990e8f22e9689165b068737b3/_scripts/Submit-VirusTotal.ps1>
# all ownership and credits goes to flcdrg for this helper code.

<#
.SYNOPSIS
    Submit file(s) to VirusTotal
.NOTES
    Call from global:au_AfterUpdate
#>
function Invoke-VirusTotalScan ($Package) {
choco install -y vt-cli
    if (-not (Test-Path env:VT_APIKEY)) {
        Write-Warning "VT_APIKEY not set, skipping submission"
        return
    }

    choco install -y vt-cli

    $existingFileName32 = $Latest.FileName32
    $existingFileName64 = $Latest.FileName64

    if ($Package.RemoteVersion -ne $Package.NuspecVersion) {
        if (!$existingFileName32 -and !$existingFileName64) {
            try {
                Get-RemoteFiles -NoSuffix
            } catch {
                # Get-RemoteFiles derives the file extension from the last '.' in the whole
                # URL. URLs with no extension in their final segment (e.g. SourceForge's
                # trailing "/download") make it pick up a bogus multi-segment "extension",
                # producing an invalid nested path and throwing. VirusTotal submission is
                # best-effort - don't let it abort the whole package update.
                Write-Warning "Get-RemoteFiles failed, skipping VirusTotal binary submission: $_"
            }
        }

        if ($Latest.FileName32) {
            $file = [IO.Path]::Combine("tools", $Latest.FileName32)

            Write-Output "Submitting file $file to VirusTotal"

            # Assumes vt-cli Chocolatey package is installed!
            vt.exe scan file $file --apikey $env:VT_APIKEY

            if (!$existingFileName32) {
                Remove-Item $file -ErrorAction Ignore
                $Latest.Remove("FileName32")
            }
        }

        if ($Latest.FileName64) {
            $file = [IO.Path]::Combine("tools", $Latest.FileName64)

            Write-Output "Submitting file $file to VirusTotal"

            # Assumes vt-cli Chocolatey package is installed!
            vt.exe scan file $file --apikey $env:VT_APIKEY

            if (!$existingFileName64) {
                Remove-Item $file -ErrorAction Ignore
                $Latest.Remove("FileName64")
            }
        }

        $nupkgFile = Get-ChildItem "*.nupkg" | ForEach-Object {
          Write-Output "Submitting file $file to VirusTotal"

          # Assumes vt-cli Chocolatey package is installed!
          vt.exe scan file $_ --apikey $env:VT_APIKEY
        }
    }
}
