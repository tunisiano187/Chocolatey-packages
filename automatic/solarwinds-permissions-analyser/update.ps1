$ErrorActionPreference = 'Stop'
import-module au

$releases = "https://downloads.solarwinds.com/solarwinds/Release/FreeTool/SolarWinds-Permissions-Analyzer.zip"

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
     }
}

function global:au_GetLatest {
	$url32 = $releases

    $tempfile = New-TemporaryFile
    Invoke-WebRequest -Uri $url32 -OutFile $tempfile
    7z x $tempfile
    7z x SolarWindsPermissionsAnalyzerTool.msi
    $File = Join-Path $(Get-Location) "PermissionsAnalyzer.exe"
    $version=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion.trim()

	$Latest = @{ URL32 = $url32; Version = $version }
    return $Latest
}

update -ChecksumFor 32
