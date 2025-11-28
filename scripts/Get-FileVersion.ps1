<#
.SYNOPSIS
    Extract version from File if available

.DESCRIPTION
    Extract the informations from a file and output the version.

.PARAMETER url
    The url to the file (required for remote file)

.PARAMETER File
    Location of the file (for files already on disk)

.OUTPUTS
    The version of the file if it is available.
    The Hash
    The algorythm used
    The File Size in MB
    The File Name
#>
function Get-FileVersion {
    param(
        [string]$url,
        [string]$File,
        [string]$checksumType = "SHA512",
        [string]$useragent = "Chocolatey",
        [switch]$keep
    )
    if($env:ChocolateyChecksumType) { $checksumType = $env:ChocolateyChecksumType }

    if($url.Trim().Length -gt 0) {
        if($($url.split('/')[-1]) -match 'sourceforge') {
            $FileName = $url.split('/')[-1]
        } else {
            $FileName = $url.split('/')[-2]
        }
        $tempFile = Join-Path $env:TEMP $($FileName)
        import-module C:\ProgramData\chocolatey\helpers\chocolateyInstaller.psm1 -ErrorAction SilentlyContinue -Force
        try {
            $FileName = Get-WebFileName -url $url -defaultName $FileName
            $tempFile = Join-Path $env:TEMP $FileName
        }
        catch {
            $FileName = $null
        }

        if($tempFile -match '\?') {
            $tempFile = $tempFile.Split('?')[0]
        }
        Invoke-WebRequest -Uri $url -OutFile $tempFile -UserAgent $useragent -UseBasicParsing
        try {
            [version]$version=$([System.Diagnostics.FileVersionInfo]::GetVersionInfo($tempFile).ProductVersion).trim()
        }
        catch {
            try {
                [version]$version=$([System.Diagnostics.FileVersionInfo]::GetVersionInfo($tempFile).FileVersion).trim()
            }
            catch {
                try {
                    $version = (Get-Version $url).Version
                }
                catch {
                    $version=$null
                }
            }
        }
        try {
            $FileSize = (((Get-Item -Path $tempFile).Length)/1MB)
        }
        catch {
            $FileSize=$null
        }
        $checksum = (Get-FileHash -Path $tempFile -Algorithm $checksumType).Hash
        if(! $keep) {
            Remove-Item -Path $tempFile -Force
            $tempFile = "Removed"
        }
    } else {
        try {
            [version]$version=$([System.Diagnostics.FileVersionInfo]::GetVersionInfo($tempFile).ProductVersion).trim()
        }
        catch {
            try {
                [version]$version=$([System.Diagnostics.FileVersionInfo]::GetVersionInfo($tempFile).FileVersion).trim()
            }
            catch {
                try {
                    $version = (Get-Version $url).Version
                }
                catch {
                    $version=$null
                }
            }
        }
        $checksum = (Get-FileHash -Path $File -Algorithm $checksumType).Hash
    }
    if($FileName -like "*?*") {
        $FileName = ($FileName.split('?'))[0]
    }

    $result = @{Version = $version; Checksum = $checksum; ChecksumType = $checksumType; TempFile = $tempFile; FileSize = $FileSize; FileName = $FileName}
    return $result
}
