import-module au

$release = 'https://www.ubackup.com/ss/download/adb/AOMEIBackupperStd.exe'

function global:au_SearchReplace {
	@{
    'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumtype\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
  Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$File = Join-Path $env:TEMP "backupper-standard.exe"
	Invoke-WebRequest -Uri $release -OutFile $File
	$version=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion.trim()
  	Remove-Item -Force $File

  	$Latest = @{ URL32 = $release; Version = $version }
	return $Latest
}

update -ChecksumFor 32
