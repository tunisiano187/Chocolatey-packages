import-module au

$releases = 'https://johnsad.ventures/software/backgroundswitcher/windows/'

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
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
		}
	}
}

function global:au_GetLatest {
	$jbs = (Invoke-WebRequest -Uri $releases)
	$url32 = ($jbs.Links | Where-Object {$_ -match 'exe'})[0].href
	
	$working_dir = "."
	$install_fname = 'jbs.exe'
	Write-host 'Download'
	Invoke-WebRequest -Uri $url32 -OutFile "$working_dir\$install_fname"
	Write-host 'Install'
	. $working_dir/$install_fname /S
	$version=Get-Version('switcher')
	
	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32