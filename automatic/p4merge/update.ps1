$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'https://cdist2.perforce.com/perforce/'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
		}
		"tools\VERIFICATION.txt"      = @{
			"(?i)(link:).*"        				= "`${1} $($Latest.URL32)"
			"(?i)(checksum:).*" 				= "`${1} $($Latest.Checksum32)"
			"(?i)(checksumtype:).*" 			= "`${1} $($Latest.ChecksumType32)"
			"(?i)(license:).*" 					= "`${1} $($Latest.License)"
		}
	}
}


function global:au_BeforeUpdate($Package) {
	Get-RemoteFiles -Purge -NoSuffix
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	Write-Output 'Check Folder'
	$version_folder = ((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object  {$_.href -match '^r\d+([.]\d+)?'} | ForEach-Object {($_.href -replace '[^.\d]', '')} | Sort-Object -Descending)
	$newversion='0.0'
	$version='0.0'
	foreach ($item in $version_folder) {
		try {
			$ver = $item.replace(',','.')
			$linktest = "https://cdist2.perforce.com/perforce/r$($ver)/doc/user/p4vnotes.txt"
			$license = "https://cdist2.perforce.com/perforce/r$($ver)/doc/user/p4v_license.txt"
			Invoke-WebRequest -Uri $linktest -OutFile "$env:TEMP\p4v.txt"
			Invoke-WebRequest -Uri $license -OutFile ".\tools\LICENSE.txt"
            $newversion = $($(Get-Content "$env:TEMP\p4v.txt" | Where-Object { $_ -match 'version'}).trim() | Where-Object { $_ -match '^Version'})[0].split(' ')[-1]
            if([version]$version -lt [version]$newversion)
			{
				$url64 = "https://cdist2.perforce.com/perforce/r$($ver)/bin.ntx64/p4vinst64.exe"

                $version = $newversion
			}
		}
		catch {
			Write-Verbose "V$($item) Not found"
		}
    }
	Invoke-WebRequest -Uri $url64 -OutFile ".\tools\p4vinst64.exe"

	if($version -eq "2022.3") {
		$version = "2022.3.0.2022112301"
	}
	$Latest = @{ URL32 = $url64; Version = $version; License = $license }
	return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion
