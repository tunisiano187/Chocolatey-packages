import-module au

$releases = 'http://www.smorgasbordet.com/pellesc/download.htm'
$baseurl = 'http://www.smorgasbordet.com/pellesc'

function global:au_SearchReplace {
	@{
		".\legal\VERIFICATION.txt" = @{
			"(?i)(^\s*url(32)?\:\s*).*"         = "`${1}<$($Latest.URL32)>"
			"(?i)(^\s*checksum(32)?\:\s*).*"    = "`${1}$($Latest.Checksum32)"
			"(?i)(^\s*checksum\s*type\:\s*).*"  = "`${1}$($Latest.ChecksumType32)"
		  }
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$page = Invoke-WebRequest -Uri $releases -UseBasicParsing
	$url32 = "$baseurl/$($page.Links.href | Where-Object {$_ -match ".exe$"} | Select-Object -First 1)"
	Update-Metadata -key "releaseNotes" -value $($page.Links.href | Where-Object {$_ -match "changes_"} | Select-Object -First 1)
	$regexPattern = "The current version is <b>(\d+\.\d+)</b>"
	$versionMatch = $page.Content | Select-String -Pattern $regexPattern -AllMatches
	$version = $versionMatch.Matches[0].Groups[1].Value
	$userAgent = [Microsoft.PowerShell.Commands.PSUserAgent]::Chrome
	$Headers = @{
		"referer"=$releases
	}
	Invoke-WebRequest -Uri $url32 -OutFile "tools/setup.exe" -Headers $Headers
	$checksum = (Get-FileHash -Path "tools/setup.exe" -Algorithm $env:ChocolateyChecksumType).Hash
	$checksumType = $env:ChocolateyChecksumType

	$Latest = @{ URL32 = $url32; Version = $version; Checksum32 = $checksum; ChecksumType32 = $checksumType }
	return $Latest
}

update -ChecksumFor none
