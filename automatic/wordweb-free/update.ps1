$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'https://wordweb.info/free/'

function global:au_SearchReplace {
	@{
		"legal\VERIFICATION.txt"      = @{
			"(?i)(link32:).*"        			= "`${1} $($Latest.URL32)"
			"(?i)(checksum32:).*" 				= "`${1} $($Latest.Checksum32)"
			"(?i)(checksumtype:).*" 			= "`${1} $($Latest.ChecksumType32)"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Import-Module ..\..\scripts\au_extensions.psm1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$page = Invoke-WebRequest -Uri $releases -UseBasicParsing
	$regexPattern = 'WordWeb (\d+(\.\d+)*)'
	$versionMatch = $page.Content | Select-String -Pattern $regexPattern -AllMatches
	$version = $versionMatch.Matches[0].Groups[1].Value
	$url32 = ($page.Links | Where-Object {$_.href -match ".exe$"}).href
	$fileName = $url32.split("/")[-1]
	$file = "tools/$fileName"
	Invoke-WebRequest -Uri $url32 -OutFile $file -UseBasicParsing
	$checksum = (Get-FileHash -Path $file -Algorithm $env:ChocolateyChecksumType).Hash

	# Root cause of the "Package parameters incorrect, either File or File64 must be specified"
	# verifier failure on v10.62.0: scripts/Invoke-VirusTotalScan.ps1 (called from au_AfterUpdate
	# below) treats an unset $Latest.FileName32 as "no file has been tracked yet for this
	# package" -- it re-downloads via its own Get-RemoteFiles purely to scan it, then DELETES
	# whatever it downloaded once the scan is done. That's correct for download-on-install
	# packages, Where-Object the scanned file is disposable scratch data -- but wordweb-free embeds the
	# exe (tools/chocolateyInstall.ps1 finds it via Get-ChildItem *.exe), so the shared script
	# wrongly deleted the just-downloaded exe right after au_GetLatest placed it above. AU still
	# reported success since nothing threw -- the nupkg was committed with no exe in tools/, so
	# Get-ChildItem returned nothing and Install-ChocolateyInstallPackage got an empty -file. This
	# is the exact same bug already found and fixed for freeplane/osfmount/vlc-skins. Setting
	# FileName32 marks the file as pre-existing, so the scan uses it directly and skips the
	# delete-after-scan step.
	$Latest = @{ URL32 = $url32; Version = $version; Checksum32 = $checksum; ChecksumType32 = $env:ChocolateyChecksumType; FileName32 = $fileName }
	return $Latest
}

update -ChecksumFor none -NoCheckChocoVersion
