import-module chocolatey-AU

$releases = 'https://www.crucial.com/support/storage-executive'

function global:au_GetLatest {
	$package = [AUPackage]::new( $pwd )
	$download_page	= Invoke-WebRequest -UseBasicParsing -Uri $releases
	$filere			= '\.zip$'

	$verre			= '(?<=Version\s)[\d.-]+(?=\s)'
	$download_page.Content -match $verre | Out-Null
	$version		= $Matches[0].ToString()
	#short-circuit if there is no new update to the webpage
	if ($version -eq $package.NuspecVersion) {
		return @{version = $version}
	}

	$url64			= $download_page.links | ? href -match $filere | select -First 1 -expand href
	if ($url64.StartsWith("/")) {
		# url is NOT fully qualified
		$url64 = ([System.Uri]$releases).scheme + '://' + ([System.Uri]$releases).authority + $url64
	}
	$checksumType	= 'sha256'
	$checksum64		= Get-RemoteChecksum -Algorithm $checksumType -Url $url64

	return @{
		Url64             = $url64
		Version           = $version
		Checksum64        = $checksum64
		ChecksumType64    = $checksumType
	}
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

Update-Package -ChecksumFor 64
