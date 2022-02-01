$ErrorActionPreference = 'Stop'
import-module au

$releases 		= 'https://www.bkool.com/en/download/windows'

function Get-Version($name) {
	$version_file=$(../../tools/Get-InstalledApps.ps1 -ComputerName $env:COMPUTERNAME -NameRegex $name).DisplayVersion
	while($version_file.count -eq 0)
	{
		$version_file=$(../../tools/Get-InstalledApps.ps1 -ComputerName $env:COMPUTERNAME -NameRegex $name).DisplayVersion
		Start-Sleep -Seconds 1
	}
	return $version_file
}

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      			= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 			= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 		= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_GetLatest {
	$url32 = $releases
	$File = Join-Path $env:TEMP "bkool.exe"
	(new-object System.Net.WebClient).DownloadFile($url32,$File)
	Write-Output 'Install'
	. $File /quiet
	$version=Get-Version('bkool')
	

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

#Test-Package
update
