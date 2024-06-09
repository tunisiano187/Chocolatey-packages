import-module au

$release = 'https://www.ubackup.com/server.html'

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
  $page = Invoke-WebRequest -Uri $release
  $url32 = "https://www.ubackup.com$($page.Links.href | Where-Object {$_ -match ".exe$"} | Where-Object {$_ -match "Server"} | Select-Object -First 1)"
  $FileVersion = Get-FileVersion $url32

  $Latest = @{ URL32 = $url32; Version = $FileVersion.Version; Checksum32 = $FileVersion.Checksum; ChecksumType = $FileVersion.ChecksumType }
	return $Latest
}

update -ChecksumFor none