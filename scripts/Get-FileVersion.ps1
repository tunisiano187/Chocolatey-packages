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
        [uri]$url,
        [string]$File,
        [string]$checksumType = "SHA512"
    )
    if($env:ChocolateyChecksumType) { $checksumType = $env:ChocolateyChecksumType }

    if($null -ne $url) {
        $tempFile = New-TemporaryFile
        Invoke-WebRequest -Uri $url -OutFile $tempFile
        try {
            [version]$version=$([System.Diagnostics.FileVersionInfo]::GetVersionInfo($tempFile).FileVersion).trim()
        }
        catch {
            $version=$null
        }
        $checksum = (Get-FileHash -Path $tempFile -Algorithm $checksumType).Hash
        Remove-Item -Path $tempFile -Force
    } else {
        try {
            [version]$version=$([System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion).trim()
        }
        catch {
            $version=$null
        }
        $checksum = (Get-FileHash -Path $File -Algorithm $checksumType).Hash
    }

    $result = @{Version = $version; CHECKSUM = $checksum; ChecksumType = $checksumType}
    return $result
}
