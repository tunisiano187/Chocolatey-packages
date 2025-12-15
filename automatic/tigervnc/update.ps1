$ErrorActionPreference = 'Stop'
import-module chocolatey-AU
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

function global:au_AfterUpdate($Package) {
	. ..\..\scripts\Invoke-VirusTotalScan.ps1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$File = "$env:TEMP\tigervnc.xml"
	Invoke-WebRequest -Uri $releases -OutFile $File
	$xml = Get-Content $File
	$links=$xml | Where-Object {$_ -match '.exe/download'} | Where-Object {$_ -match 'link'}
	$url32 = Get-RedirectedUrl ($links.Split('<|>') | Where-Object {$_ -match 'tigervnc-[0-9]'})
	$url64 = Get-RedirectedUrl ($links.Split('<|>') | Where-Object {$_ -match 'tigervnc64-[0-9]'})
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $url32 -keep
	Move-Item -Path $FileVersion.TempFile -Destination "tools\tigervnc.exe"
	$FileVersion64 = Get-FileVersion $url64 -keep
	Move-Item -Path $FileVersion64.TempFile -Destination "tools\tigervnc64.exe"

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $FileVersion.Version; Checksum32 = $FileVersion.Checksum; ChecksumType32 = $FileVersion.ChecksumType; Checksum64 = $FileVersion64; ChecksumType64 = $FileVersion64.ChecksumType64 }
	return $Latest
}

update -ChecksumFor none -NoCheckChocoVersion
