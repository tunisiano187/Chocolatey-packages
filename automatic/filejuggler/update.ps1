import-module au

$release = 'https://www.filejuggler.com/download/filejuggler.exe'

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
	$installer = $release
	$working_dir = "."
	$install_fname = 'filejuggler.exe'
	Write-host 'Download'
	Invoke-WebRequest -Uri $installer -OutFile "$working_dir\$install_fname"
	Write-host 'Install'
	. $working_dir/$install_fname '/qb'
	$version=Get-Version('Juggler')
	Write-host "Version : $version"
	$url32 = $release
	
	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32
