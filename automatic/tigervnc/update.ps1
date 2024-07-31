$ErrorActionPreference = 'Stop'
import-module au
$curDir	= "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$toolsDir = Join-Path $curDir "tools"
$releases 	= 'https://sourceforge.net/projects/tigervnc/rss?path=/stable'
$options 	=
@{
  Headers = @{
    UserAgent = 'Wget';
  }
}

function global:au_SearchReplace {
	@{
		"legal\VERIFICATION.txt"      = @{
			"(?i)(link32:).*"        			= "`${1} $($Latest.URL32)"
			"(?i)(checksum32:).*" 				= "`${1} $($Latest.Checksum32)"
			"(?i)(checksumtype:).*" 			= "`${1} $($Latest.ChecksumType32)"
			"(?i)(link64:).*"        			= "`${1} $($Latest.URL64)"
			"(?i)(checksum64:).*" 				= "`${1} $($Latest.Checksum64)"
		}
		"$($Latest.PackageName).nuspec" = @{
			"(\<releaseNotes\>).*?(\</releaseNotes\>)"		= "`${1}https://github.com/TigerVNC/tigervnc/releases/tag/$($Latest.Version)`$2"
		}
	}
}

function global:au_BeforeUpdate {
	$file32 = Join-Path $toolsDir "tigervnc.exe"
	$file64 = Join-Path $toolsDir "tigervnc64.exe"

	$cli = New-Object System.Net.WebClient;
    $cli.Headers['User-Agent'] = 'Wget';
    $cli.DownloadFile($Latest.URL32 , $file32)
	$cli = New-Object System.Net.WebClient;
    $cli.Headers['User-Agent'] = 'Wget';
    $cli.DownloadFile($Latest.URL64 , $file64)

	$Latest.ChecksumType32 = "SHA256"
	$Latest.ChecksumType64 = $Latest.ChecksumType32
	$Latest.Checksum32 = (Get-FileHash -Path $file32 -Algorithm $Latest.ChecksumType32).Hash
	$Latest.Checksum64 = (Get-FileHash -Path $file64 -Algorithm $Latest.ChecksumType64).Hash
}

  function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$File = "$env:TEMP\tigervnc.xml"
	Invoke-WebRequest -Uri $releases -OutFile $File
	$xml = Get-Content $File
	$links=$xml | Where-Object {$_ -match '.exe/download'} | Where-Object {$_ -match 'link'}  | Select-Object -First 1
	$url32 = Get-RedirectedUrl ($links.Split('<|>') | Where-Object {$_ -match '.exe/download'})
	$version = (Get-Version $url32).Version
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $url32 -keep
	Move-Item -Path $FileVersion.TempFile -Destination "tools\tigervnc-$($version)-win.zip"

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version; Options = $options }
	return $Latest
}

update -NoCheckUrl -ChecksumFor none -NoCheckChocoVersion