import-module au

$url32 = 'https://www.odrive.com/downloaddesktop?platform=win'

function Get-Version($name) {
	$version_file=$(../../tools/Get-InstalledApps.ps1 -ComputerName $env:COMPUTERNAME -NameRegex $name).DisplayVersion | select-object -first 1
	while($version_file.count -eq 0)
	{
		$version_file=$(../../tools/Get-InstalledApps.ps1 -ComputerName $env:COMPUTERNAME -NameRegex $name).DisplayVersion | select-object -first 1
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
	$working_dir = "."
	$install_fname = 'odrive.exe'
	Write-host 'Download'
	Invoke-WebRequest -Uri $url32 -OutFile "$working_dir\$install_fname"
	Write-host 'Install'
	. $working_dir/$install_fname /quiet
	$version=Get-Version('^odrive$')
	Write-host "Version : $version"
	del $working_dir/$install_fname
	
	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32