import-module au

$release = 'https://account.axcrypt.net/download/axcrypt-2-setup.exe'

function global:au_SearchReplace {
	@{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*url(32)?\:\s*).*"        = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum(32)?\:\s*).*"   = "`${1}$($Latest.Checksum32)"
      "(?i)(^\s*checksum\s*type\:\s*).*" = "`${1}$($Latest.ChecksumType32)"
    }
	}
}

function global:au_BeforeUpdate($Package) {
  Get-RemoteFiles -Purge -NoSuffix
}

function global:au_AfterUpdate($Package) {
  Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$File = Join-Path $env:TEMP "axcrypt.exe"
	Invoke-WebRequest -Uri $release -OutFile $File
	$version=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion.trim()
  Remove-Item -Force $File

  $Latest = @{ URL32 = $release; Version = $version }
	return $Latest
}

update -ChecksumFor none
