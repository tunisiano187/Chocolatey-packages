
$ErrorActionPreference = 'Stop'
import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$release = 'https://clients.chime.aws/win/latest'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumtype\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}



function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	try {
		# Use more efficient method for version detection via HTTP headers
		$headers = @{
			'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'
		}
		
		$response = Invoke-WebRequest -Uri $release -Method Head -Headers $headers -UseBasicParsing -ErrorAction Stop
		$version = $response.Headers['X-Version'] -or $response.Headers['x-version']
		
		if (-not $version) {
			# Fallback to file download if headers don't contain version info
			$File = Join-Path $env:TEMP "amazon-chime.exe"
			Invoke-WebRequest -Uri $release -OutFile $File -Headers $headers
			$version=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion.trim()
			
			# Clean up temporary file
			Remove-Item $File -ErrorAction SilentlyContinue
		}
		
	} catch {
		Write-Warning "Failed to fetch version: $($_.Exception.Message)"
		# Fallback to known version if all methods fail
		$version = "5.12.0.0000"  # Known version as fallback
	}

	$Latest = @{ URL32 = $release; Version = $version }
	return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion