import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$release = 'https://www.ubackup.com/server.html'

function global:au_SearchReplace {
	@{
    ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url(32)?\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(^[$]checksum(32)?\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType(32)?\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
    }
	}
}

function global:au_BeforeUpdate {
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $Latest.URL32
	$Latest.Checksum32 = $FileVersion.Checksum
	$Latest.ChecksumType32 = $FileVersion.checksumType
}

function global:au_AfterUpdate($Package) {
  Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
  $page = Invoke-WebRequest -Uri $release
  $url32 = Get-RedirectedUrl  "https://www.ubackup.com$($page.Links.href | Where-Object {$_ -match ".exe$"} | Where-Object {$_ -match "Server"} | Select-Object -First 1)"
  $url = "https://www.aomeitech.com/download.html"
  $response = Invoke-WebRequest -Uri $url
  $versionPattern = 'v<span\s+data--release-product="AB"\s+data--release="version">(\d+\.\d+\.\d+)<\/span>'
  $match = [regex]::Match($response.Content, $versionPattern)
	$version = $match.Groups[1].Value

  $Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor none -NoCheckChocoVersion
