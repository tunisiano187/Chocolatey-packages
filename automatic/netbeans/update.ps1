$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://netbeans.apache.org/front/main/index.html'
$github = 'https://github.com/apache/netbeans/releases/latest'
$Owner = $github.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $github.Split('/') | Select-Object -Last 1 -Skip 2

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Update-Metadata -key "licenseUrl" -value $Latest.LicenseUrl
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$Page = Invoke-WebRequest -Uri $releases -UserAgent "Update checker of Chocolatey Community Package 'Netbeans'"
	$ReleasePage = ($Page.Links | Where-Object {$_ -match "download/n"}).href
	$ReleasePage = [Uri]::new([Uri]::new($releases), $ReleasePage).ToString()
	$Page = Invoke-WebRequest -Uri $ReleasePage -UserAgent "Update checker of Chocolatey Community Package 'Netbeans'"
	$Links = ($Page.Links | Where-Object {$_ -match "exe"}).href
	$closestrelease = $Links | Where-Object {$_ -match "exe$"}
	$release = ((Invoke-WebRequest -Uri $closestrelease).Links | Where-Object {$_.href -match "exe$"} | Select-Object -First 1).href
	$ChecksumLink = ($Links | Where-Object {$_ -match "exe."} | Where-Object {$_ -notmatch "asc"})
	$ChecksumType = $ChecksumLink.split(".")[-1]
	$Checksum = (invoke-WebRequest -Uri $ChecksumLink).content.split(' ')[0]

	$tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo -Latest
	Update-Metadata -key "releaseNotes" -value $tags.html_url

	$version=$release.Split('/') | Where-Object {$_ -match "[0-9][0-9]"} | Where-Object {$_ -notmatch 'exe'}
	if($version -notmatch '\.') {
		$version+=".0"
	}

	$Latest = @{ URL64 = $release; Checksum64 = $Checksum; ChecksumType64 = $ChecksumType; Version = $version }
	return $Latest
}

update -ChecksumFor none
