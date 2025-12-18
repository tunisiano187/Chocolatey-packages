import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$release = 'https://downloader.axcrypt.net/windows/axcrypt-3-appsetup-win_x64.msi'

function global:au_SearchReplace {
	@{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*url(32)?\:\s*).*"        = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum(32)?\:\s*).*"   = "`${1}$($Latest.Checksum32)"
      "(?i)(^\s*checksum\s*type\:\s*).*" = "`${1}$($Latest.ChecksumType32)"
    }
	}
}

function global:au_BeforeUpdate {
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $Latest.URL32 -keep
  Move-Item -Path $FileVersion.TempFile -Destination "tools/$($FileVersion.FileName)"
	$Latest.Checksum32 = $FileVersion.Checksum
	$Latest.ChecksumType32 = $FileVersion.checksumType
}

function global:au_AfterUpdate($Package) {
  Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$page = Invoke-WebRequest -Uri "https://axcrypt.net/information/release-notes/" -UseBasicParsing
	$regexPattern = 'Windows Desktop (\d+(\.\d+)*)'
	$versionMatch = $page.Content | Select-String -Pattern $regexPattern -AllMatches
	$version = $versionMatch.Matches[0].Groups[1].Value

  $Latest = @{ URL32 = $release; Version = $version }
	return $Latest
}

update -ChecksumFor none -NoCheckChocoVersion
