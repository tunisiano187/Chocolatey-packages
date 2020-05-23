import-module au

$url32 = 'https://get.fing.com/fing-desktop-releases/windows/Fing.exe'

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
	$working_dir = "."
	$install_fname = 'fing.exe'
	Write-host 'Download'
	Invoke-WebRequest -Uri $url32 -OutFile "$working_dir\$install_fname"
	Write-host 'Install'
	. $working_dir/$install_fname /S
	$version=Get-Version('fing')
	Write-host "Version : $version"
	
	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32