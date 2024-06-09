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
function Get-RedirectedUrl {
    param(
        [uri]$url,
        [path]$File
    )

    if($null -ne $url) {
        $tempFile = New-TemporaryFile
        Invoke-WebRequest -Uri $url -OutFile $tempFile
        $result = $tempFile.VersionInfo.ProductVersion
        Remove-Item -Path $tempFile -Force
    } else {
        $result=$([System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion).trim()
    }

    return $result
}
