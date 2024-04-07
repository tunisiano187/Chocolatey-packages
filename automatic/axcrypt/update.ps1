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

try {
  update -ChecksumFor none
} catch {
  $ignore = "Chocolatey v2.2.2 Attempting to push axcrypt.2.1.1647.nupkg to https://push.chocolatey.org An error has occurred. It's possible the package version already exists on the repository or a nuspec element is invalid. See error below... Response status code does not indicate success: 409 (Conflict)."
  if ($_ -match $ignore) { Write-Output $ignore; 'ignore' } else { throw $_ }
}
