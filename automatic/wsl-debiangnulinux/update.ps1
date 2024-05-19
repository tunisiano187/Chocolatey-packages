$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://raw.githubusercontent.com/microsoft/WSL/master/distributions/DistributionInfo.json'

function global:au_SearchReplace {
	@{
		"legal\VERIFICATION.txt"      = @{
			"(?i)(link:).*"        				= "`${1} $($Latest.URL32)"
			"(?i)(checksum:).*" 				= "`${1} $($Latest.Checksum32)"
			"(?i)(checksumtype:).*" 			= "`${1} $($Latest.ChecksumType32)"
		}
	}
}

function global:au_BeforeUpdate($Package) {
	$tmpfile = Join-Path $env:TEMP "chocolatey\wsl-debiangnulinux.zip"
	$unzipfolder = Join-Path $env:TEMP "chocolatey\wsl-debiangnulinux"
	New-Item -Path $unzipfolder -ItemType Directory -Force
	Invoke-WebRequest -Uri $Latest.URL32 -OutFile $tmpfile
	Expand-Archive -Path $tmpfile -DestinationPath $unzipfolder
	$file = (Get-ChildItem -Path $unzipfolder -Filter "*x64.appx").FullName
	$Latest.Checksum32 = (Get-FileHash -Path $file -Algorithm $env:ChocolateyChecksumType).Hash
	$Latest.ChecksumType32 = $env:ChocolateyChecksumType
	Move-Item $file "tools\"
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	# Get Url
	$json = Invoke-RestMethod -Uri $releases -Method Get
	$Debian = $json.Distributions | Where-Object {$_.Name -eq 'Debian'}
	$url = $Debian.Amd64PackageUrl
	
	$page = Invoke-WebRequest -Uri "https://apps.microsoft.com/detail/9msvkqc78pk6?hl=en-us&gl=US"
	$regexPattern = 'Debian release (\d+(\.\d+)*)(.*)'
	$versionMatch = $page.Content | Select-String -Pattern $regexPattern -AllMatches
	$version = "$($versionMatch.Matches[0].Groups[1].Value).0.$((Get-Version $url).Version.toString().replace('.',''))"
	$title = "Debian GNU/Linux _num_ (_name_) for Windows Subsystem for Linux (Install)"
	if ($versionMatch.Matches[0].Groups[3].Value.Trim().replace('\','') -match '\("([^"]+)"\)') {
		$name = $matches[1]
	}
	$title = $title.Replace('_num_',$($versionMatch.Matches[0].Groups[1].Value)).Replace('_name_',$name)
	Update-Metadata -key 'title' -value $title
	
	$Latest = @{ URL32 = $url; Version = $version }
	return $Latest
}

update -ChecksumFor 32
