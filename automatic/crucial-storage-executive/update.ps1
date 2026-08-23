import-module chocolatey-AU

$releases = 'https://www.crucial.com/support/storage-executive'

function global:au_BeforeUpdate {
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $Latest.URL64
	$Latest.Checksum64 = $FileVersion.Checksum
	$Latest.ChecksumType64 = $FileVersion.checksumType
}

function global:au_GetLatest {
	$package = [AUPackage]::new( $pwd )
	# Without a browser-like User-Agent, crucial.com rejects the request outright ("Request
	# Rejected... consult with your administrator", a WAF page) instead of serving the real
	# page -- the previous regex match against that rejection page silently failed, leaving
	# $Matches unset and throwing an opaque "Cannot index into a null array" on $Matches[0].
	$download_page	= Invoke-WebRequest -UseBasicParsing -Uri $releases -UserAgent 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36'
	$filere			= '\.zip$'

	$verre			= '(?<=Version\s)[\d.-]+(?=\s)'
	if ($download_page.Content -notmatch $verre) {
		throw "Could not find version pattern '$verre' on $releases"
	}
	$version		= $Matches[0].ToString()
	#short-circuit if there is no new update to the webpage
	$url64			= $download_page.links | Where-Object href -match $filere | Select-Object -First 1 -expand href
	if ($url64.StartsWith("/")) {
		# url is NOT fully qualified
		$url64 = ([System.Uri]$releases).scheme + '://' + ([System.Uri]$releases).authority + $url64
	}

	return @{
		Url64             = $url64
		Version           = $version
	}
}

function global:au_AfterUpdate($Package) {
	Import-Module ..\..\scripts\au_extensions.psm1
	Invoke-VirusTotalScan $Package
}

function global:au_SearchReplace {
  @{
      'tools\chocolateyInstall.ps1' = @{
          "(^[$]url64\s*=\s*)('.*')"       	    = "`$1'$($Latest.Url64)'"
		  "(^[$]version\s*=\s*)('.*')"			= "`$1'$($Latest.Version)'"
          "(^[$]checksum64\s*=\s*)('.*')"     	= "`$1'$($Latest.Checksum64)'"
          "(^[$]checksumType64\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType64)'"
      }
  }
}

Update-Package -ChecksumFor none
