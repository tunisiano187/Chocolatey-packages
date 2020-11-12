$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://cdist2.perforce.com/perforce/'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
			"(^[$]url64\s*=\s*)('.*')"      	= "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" 	= "`$1'$($Latest.Checksum64)'"
			"(^[$]checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
		}
	}
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
			Invoke-WebRequest -Uri $linktest -OutFile "$env:TEMP\p4v.txt"
            $newversion = $($(Get-Content "$env:TEMP\p4v.txt" | Where-Object { $_ -match 'version'}).trim() | Where-Object { $_ -match '^Version'})[0].split(' ')[-1]
            if([version]$version -lt [version]$newversion)
			{
				$url32 = "https://cdist2.perforce.com/perforce/r$($ver)/bin.ntx86/p4vinst.exe"
				$url64 = "https://cdist2.perforce.com/perforce/r$($ver)/bin.ntx64/p4vinst64.exe"

                $version = $newversion
			}
		}
		catch {
			Write-Verbose "V$($item) Not found"
		}
    }
if($version -eq "2020.2.3") { $version = "2020.2.20201107"}
	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

update
