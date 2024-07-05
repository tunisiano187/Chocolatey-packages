$ErrorActionPreference = 'Stop'
import-module au

$releases = 'http://paul.glagla.free.fr/captureflux_en.htm'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$page = Invoke-WebRequest -Uri $releases
	$url32 = "https://paulglagla.com/$($page.Links.href | Where-Object {$_ -match "zip$"} | Select-Object -First 1)"

	$ExtractFolder = Join-Path $env:TEMP "Chocolatey/captureflux"
	$File = Join-Path $env:TEMP $($url32.Split('/')[-1])
	Invoke-WebRequest -Uri $url32 -OutFile $File
	Expand-Archive -Path $File -DestinationPath $ExtractFolder
	$checksum = (Get-FileHash -Path $File -Algorithm $env:ChocolateyChecksumType).Hash
	$File = (Get-ChildItem -Path $ExtractFolder -Filter "*.exe").FullName
	$version=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion.trim()

	$Latest = @{ URL32 = $url32; Version = $version; Checksum32 = $checksum; ChecksumType32 = $env:ChocolateyChecksumType }
	return $Latest
}

update -ChecksumFor none -NoCheckChocoVersion