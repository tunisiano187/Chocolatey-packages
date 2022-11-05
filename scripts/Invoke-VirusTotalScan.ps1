# Heavily based on <https://github.com/flcdrg/au-packages/blob/8c755c9fadb4c03990e8f22e9689165b068737b3/_scripts/Submit-VirusTotal.ps1>
# all ownership and credits goes to flcdrg for this helper code.

<#
.SYNOPSIS
    Submit file(s) to VirusTotal
.NOTES
    Call from global:au_AfterUpdate
#>
function Invoke-VirusTotalScan ($Package) {

    if (-not (Test-Path env:VT_APIKEY)) {
        Write-Warning "VT_APIKEY not set, skipping submission"
        return
    }

    $existingFileName32 = $Latest.FileName32
    $existingFileName64 = $Latest.FileName64
    $filestocheck = @()

    if ($Package.RemoteVersion -ne $Package.NuspecVersion) {
        if (!$existingFileName32 -and !$existingFileName64) {
            Get-RemoteFiles -NoSuffix
        }

        if ($Latest.FileName32) {
            $file = [IO.Path]::Combine("tools", $Latest.FileName32)

            Write-Output "Submitting file $file to VirusTotal"

            # Assumes vt-cli Chocolatey package is installed!
            #vt.exe scan file $file --apikey $env:VT_APIKEY
            $test=New-VirusScan -File $file -ApiKey $env:VT_APIKEY
            $filestocheck+=$file
        }

        if ($Latest.FileName64) {
            $file = [IO.Path]::Combine("tools", $Latest.FileName64)

            Write-Output "Submitting file $file to VirusTotal"

            # Assumes vt-cli Chocolatey package is installed!
            #vt.exe scan file $file --apikey $env:VT_APIKEY
            $test=New-VirusScan -File $file -ApiKey $env:VT_APIKEY
            $filestocheck+=$file
        }

        $nupkgFile = Get-ChildItem "*.nupkg" | % {
          Write-Output "Submitting file $file to VirusTotal"

          # Assumes vt-cli Chocolatey package is installed!
          #vt.exe scan file $_ --apikey $env:VT_APIKEY
          $test=New-VirusScan -File $_ -ApiKey $env:VT_APIKEY
          $filestocheck+=$_
        }
        start-sleep -seconds 60
        foreach ($filetocheck in $filestocheck ) {
            $test=(Get-VirusReport -ApiKey $ApiKey -File $filetocheck).data.attributes.reputation
            if($test -gt 4) {
                Write-Error "Ignoring $($Latest.PackageName) package due to virus total results - $vt positives"
	            return 'ignore'
            }
        }
        if ($Latest.FileName32 -and !$existingFileName32) {
            $file=[IO.Path]::Combine("tools", $Latest.FileName32)
            remove-item $file
            $Latest.Remove("FileName32")
        }
        if ($Latest.FileName64 -and !$existingFileName64) {
            $file=[IO.Path]::Combine("tools", $Latest.FileName64)
            remove-item $file
            $Latest.Remove("FileName64")
        }
    }
}
