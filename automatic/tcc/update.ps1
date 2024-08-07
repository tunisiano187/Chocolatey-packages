$ErrorActionPreference = 'Stop'
import-module au

function global:au_SearchReplace {
	@{
		"legal\VERIFICATION.txt"      = @{
			"(?i)(x86:).*"        				= "`${1} $($Latest.URL32)"
			"(?i)(checksum:).*" 				= "`${1} $($Latest.Checksum32)"
			"(?i)(checksum type:).*" 			= "`${1} $($Latest.ChecksumType32)"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$useragent = [Microsoft.PowerShell.Commands.PSUserAgent]::Chrome
	$page = Invoke-WebRequest -Uri "https://jpsoft.com/products/tcc.html" -UserAgent $useragent
	$url32 = ($page.Links | Where-Object {$_ -match "tcc.exe"} | Select-Object -First 1).href.Trim()
	. ..\..\scripts\Get-FileVersion.ps1
	$FileInfos = Get-FileVersion -url $url32 -keep
	Move-Item -Path $FileInfos.TempFile -Destination "tools\tcc.exe"
	$releasenotes = ($page.Links | Where-Object {$_ -match "whats-new-in-version"} | Select-Object -First 1).href.Trim()
	Update-Metadata -key "releaseNotes" -value $releasenotes -NuspecFile "tcc.nuspec"

	$Latest = @{ URL32 = $url32; Checksum32 = $FileInfos.Checksum; ChecksumType32 = $FileInfos.ChecksumType; Version = $FileInfos.Version }
	return $Latest
}

update -ChecksumFor none