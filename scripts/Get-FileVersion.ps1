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

#>
function Get-FileVersion {
    param(
        [string]$url,
        [string]$File,
        [string]$checksumType = "SHA512",
        [switch]$keep
    )
    if($env:ChocolateyChecksumType) { $checksumType = $env:ChocolateyChecksumType }

    if($null -ne $url) {
        $tempFile = Join-Path $env:TEMP $($url.split('/')[-1])
        if($tempFile -match '\?') {
            $tempFile = $tempFile.Split('?')[0]
        }
        Invoke-WebRequest -Uri $url -OutFile $tempFile
        try {
            [version]$version=$([System.Diagnostics.FileVersionInfo]::GetVersionInfo($tempFile).FileVersion).trim()
            $FileSize = (((Get-Item -Path $tempFile).Length)/1MB)
        }
        catch {
            $version=$null
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
            [version]$version=$([System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion).trim()
        }
        catch {
            $version=$null
        }
        $checksum = (Get-FileHash -Path $File -Algorithm $checksumType).Hash
    }

    $result = @{Version = $version; Checksum = $checksum; ChecksumType = $checksumType; TempFile = $tempFile; FileSize = $FileSize}
    return $result
}
