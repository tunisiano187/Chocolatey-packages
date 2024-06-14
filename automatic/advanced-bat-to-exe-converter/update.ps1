import-module au

$domain     = 'https://www.battoexeconverter.com/'
$release   = 'https://www.battoexeconverter.com/downloads/advbattoexeconverter.exe'

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
  Move-Item $FileVersion.TempFile "tools/advbattoexeconverter.exe"

  $page = Invoke-WebRequest -Uri $domain
	$regexPattern = 'V(\d+(\.\d+)*)'
	$versionMatch = $page.Content | Select-String -Pattern $regexPattern -AllMatches
	$version = $versionMatch.Matches[0].Groups[1].Value

	return @{
        URL32 = $release
        Checksum32 = $FileVersion.CHECKSUM
        ChecksumType32 = $FileVersion.ChecksumType
        Version = $version
  }
}

update -ChecksumFor none