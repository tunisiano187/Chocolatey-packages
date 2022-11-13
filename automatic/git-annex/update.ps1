$ErrorActionPreference = 'Stop'
import-module au
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$releases = 'https://downloads.kitenet.net/git-annex/windows/current/git-annex-installer.exe.info'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url32\s*=\s*)('.*')"      	= "`$1'$($Latest.URL32)'"
			"(^[$]checksum32\s*=\s*)('.*')" 	= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType32\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$file = New-TemporaryFile
	Invoke-WebRequest -Uri $releases -OutFile $file
	$info = Get-Content $file
	$url32 = $releases.Replace('.info','')
	$version = ($info.split(" ") | Where-Object {$_ -match '"[0-9][0-9]'}).split('"') | Where-Object {$_ -match "\."}
	Remove-Item $file

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update