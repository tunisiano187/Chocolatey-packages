import-module au

$release = 'https://appdownload.deepl.com/windows/full/DeepLSetup.exe'

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
			"(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
		}
	}
}

function global:au_GetLatest {
	$working_dir = "."
	$install_fname = 'DeepLSetup.exe'
	Write-host 'Download'
	Invoke-WebRequest -Uri $release -OutFile "$working_dir\$install_fname"
	. $working_dir/$install_fname /S
	$version=Get-Version('DeepL')
	Write-host "Version : $version"
	
	$Latest = @{ URL32 = $release; Version = $version }
	return $Latest
}

update -ChecksumFor 32