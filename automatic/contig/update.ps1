$ErrorActionPreference = 'Stop'
import-module au

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
	$url32 = "https://download.sysinternals.com/files/Contig.zip"
	Invoke-WebRequest -Uri $url32 -OutFile "tools/Contig.zip"
	$checksum32 = (Get-FileHash -Path "tools/Contig.zip" -Algorithm $env:ChocolateyChecksumType).Hash
	Expand-Archive -Path "tools/Contig.zip" -DestinationPath "$($env:TEMP)\contig\"
	$version = [System.Diagnostics.FileVersionInfo]::GetVersionInfo("$($env:TEMP)\contig\Contig.exe").FileVersion
    Remove-Item -Path "tools/Contig.zip" -Force
	Update-Metadata -key "copyright" -value "© 1998-$(Get-Date -Format "yyyy") Mark Russinovich"

	$Latest = @{ URL32 = $url32; Checksum32 = $checksum32; ChecksumType32 = $env:ChocolateyChecksumType; Version = $version }
	return $Latest
}

update -ChecksumFor none -NoCheckChocoVersion