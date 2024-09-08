import-module au
Import-Module ..\..\scripts\au_extensions.psm1

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

function global:au_AfterUpdate($Package) {
  Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	. ..\..\scripts\Get-FileVersion.ps1
  $FileVersion = Get-FileVersion $release -keep
  Move-Item -Path $FileVersion.TempFile -Destination "tools/$($FileVersion.FileName)"

  $Latest = @{ URL32 = $release; Checksum32 = $FileVersion.Checksum; ChecksumType32 = $FileVersion.ChecksumType; Version = $FileVersion.Version }
	return $Latest
}

update -ChecksumFor none -NoCheckChocoVersion