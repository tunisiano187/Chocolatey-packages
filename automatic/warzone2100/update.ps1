import-module chocolatey-AU

$releases = 'https://github.com/Warzone2100/warzone2100/releases/latest'
$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 2


function global:au_SearchReplace {
    @{
        'tools/chocolateyInstall.ps1' = @{
			"(^[$]url32\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum32\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]url64\s*=\s*)('.*')"      		= "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum64)'"
			"(^[$]checksumType\s*=\s*)('.*')" 		= "`$1'$($Latest.ChecksumType32)'"
		}
    }
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
  	$tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo -Latest
  	$regex = '\.exe$'
  	$urls = $tags.assets.browser_download_url | Where-Object {$_ -match $regex}
  	$url32 = $urls | Where-Object {$_ -match 'x86_installer.exe'}
	$url64 = $urls | Where-Object {$_ -match 'x64_installer.exe'}
  	Update-Metadata -key "releaseNotes" -value $tags.html_url
	$version = ($url32 -split '/' | select-object -Last 1 -Skip 1).Replace('v','')
  	if($tags.prerelease -match "true") {
    	$date = $tags.published_at.ToString("yyyyMMdd")
    	$version = "$version-pre$($date)"
  	}

  	@{
		URL32 = $url32
		URL64 = $url64
      	Version = $version
      	ReleaseNotes = $tags.html_url
  	}
}

update
