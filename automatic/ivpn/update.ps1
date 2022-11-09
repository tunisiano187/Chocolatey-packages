$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://api.github.com/repos/ivpn/desktop-app/releases/latest'
$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 2

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
		}
		"$($Latest.PackageName).nuspec" = @{
			"(\<releaseNotes\>).*?(\</releaseNotes\>)" 	= "`${1}$($Latest.ReleaseNotes)`$2"
			"(\<copyright\>).*?(\</copyright\>)" 	= "`${1}IVPN.net $((Get-Date).year)`$2"
		}
	}
}



function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo
	$url32 = ($tags[0].body.Split('
') | Where-Object {$_ -match '.exe'}).split('(|)')[-2]
	$version = $tags[0].tag_name -split 'v|/' | select-object -Last 1
	$releaseNotes="https://github.com/$($Owner)/$($repo)/releases/tag/$($tags[0].tag_name)"
	if($tags[0].prerelease -match "true") {
		$date = $tags[0].published_at.ToString("yyyyMMdd")
		$version = "$version-pre$($date)"
	}

<# 	# Cert download
	$installer = Join-Path $env:TEMP "ivpn.zip"
	$folderextract = Join-Path $env:TEMP "ivpn"
	New-Item -Path $folderextract -ItemType Directory -Force
	Invoke-WebRequest -Uri $url32 -OutFile $installer
	Expand-Archive -Path $installer -DestinationPath $folderextract -Force
	$certfile = $(Get-ChildItem -Path $folderextract -Include "*.cer" -Recurse).FullName
	$certfiledest = "tools\cert.cer"
	Copy-Item $certfile $certfiledest -Force #>


	$Latest = @{ URL32 = $url32; Version = $version; ReleaseNotes = $releaseNotes }
	return $Latest
}

update -NoCheckChocoVersion