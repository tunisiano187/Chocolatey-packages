$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://cdist2.perforce.com/perforce/'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
			"(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
			"(^[$]checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
		}
	}
}

function global:au_GetLatest {
	Write-Output 'Check Folder'
	$version_folder = ((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object  {$_.href -match '^r\d+([.]\d+)?'} | ForEach-Object {($_.href -replace '[^.\d]', '')} | Sort-Object -Descending)
	foreach ($item in $version_folder) {
		try {
			$ver = $item.replace(',','.')
			$clnt = new-object System.Net.WebClient;
			$clnt.OpenRead("https://cdist2.perforce.com/perforce/r$($ver)/bin.ntx64/p4vinst64.exe").Close();
			$date = $([datetime]$clnt.ResponseHeaders["Last-Modified"];).ToString("yyyyMMdd")
			$linktest = "https://cdist2.perforce.com/perforce/r$($ver)/doc/user/relnotes.txt"
			Invoke-WebRequest -Uri $linktest -OutFile "$env:TEMP\p4v.txt"
			if($found -ne $true -and ($date))
			{
				$version = $item.replace(',','.')
				$found = $true
				$url32 = "https://cdist2.perforce.com/perforce/r$($version)/bin.ntx86/p4vinst.exe"
				$url64 = "https://cdist2.perforce.com/perforce/r$($version)/bin.ntx64/p4vinst64.exe"

				$link = "https://cdist2.perforce.com/perforce/r$($version)/doc/user/relnotes.txt"
				Invoke-WebRequest -Uri $link -OutFile "$env:TEMP\p4v.txt"
				$version = $($(Get-Content "$env:TEMP\p4v.txt" | Where-Object { $_ -match 'version'}).trim() | Where-Object { $_ -match '^Version'})[0].split(' ')[-1]
			}
		}
		catch {
			Write-Verbose "V$($item) Not found"
		}
	}

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

update -NoCheckChocoVersion