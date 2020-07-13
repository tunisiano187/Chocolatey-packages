import-module au

$releases = 'https://github.com/gridcoin-community/Gridcoin-Research/releases/'

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
			"(^[$]url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
		}
	}
}

function global:au_GetLatest {
	Write-Output 'Check Folder'
	$installer = (((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match 'gridcoin-'} | Where-Object {$_ -match "-setup.exe"} | Where-Object {$_ -notmatch 'hotfix'} | Where-Object {$_ -notmatch 'sha256'}).href | Select-Object -First 2 | Sort-Object )
	Write-Output 'Checking version'
	$version=$installer[0].split('/')[-1].split('-')[1]
	Write-Output "Version : $version"
	$url32 = "https://github.com$($installer[0])";
	$url64 = "https://github.com$($installer[1])";

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

update -NoCheckChocoVersion