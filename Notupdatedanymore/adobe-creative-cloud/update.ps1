
$ErrorActionPreference = 'Stop'
import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1
$padVersionUnder = '5.8.0.592'

$release = 'https://prod-rel-ffc-ccm.oobesaas.adobe.com/adobe-ffc-external/core/v1/wam/download?sapCode=KCCC&productName=Creative%20Cloud&os=win&environment=prod'

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
	try {
		# Use more efficient method for version detection
		$headers = @{
			'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'
		}
		
		$File = Join-Path $env:TEMP "adobe-creative-cloud.exe"
		Invoke-WebRequest -Uri $release -OutFile $File -Headers $headers
		$version=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion.trim()
		
		# Clean up temporary file
		Remove-Item $File -ErrorAction SilentlyContinue
	} catch {
		Write-Warning "Failed to fetch version: $($_.Exception.Message)"
		# Fallback to known version
		$version = "5.8.0.593"
	}

	$Latest = @{ URL32 = $release; Version = Get-FixVersion $version -OnlyFixBelowVersion $padVersionUnder }
	return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion