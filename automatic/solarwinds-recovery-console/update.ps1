$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')"            = "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')"       = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType\s*=\s*)('.*')"   = "`$1'$($Latest.ChecksumType32)'"
            "(^[$]url64\s*=\s*)('.*')"          = "`$1'$($Latest.URL64)'"
            "(^[$]checksum64\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum64)'"
            "(^[$]checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
        }
     }
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$url32 = "https://install.mob.system-monitor.com/backup-and-recovery-rc-windows-x86.exe"
    $url64 = "https://install.mob.system-monitor.com/backup-and-recovery-rc-windows-x64.exe"

    . ..\..\scripts\Get-FileVersion.ps1
    $FileVersion32 = Get-FileVersion $url32
    $FileVersion64 = Get-FileVersion $url64

    $Latest = @{ URL32 = $url32; Version = $FileVersion32.Version; Checksum32 = $FileVersion32.Checksum; ChecksumType32 = $FileVersion32.ChecksumType; Checksum64 = $FileVersion64.Checksum; ChecksumType64 = $FileVersion64.ChecksumType64 }
    return $Latest
}

update -ChecksumFor none -NoCheckChocoVersion
