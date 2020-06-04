import-module au

$release = 'http://fold.it/portal/files/app/Foldit-win_x86.exe'

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
	$binRoot = Get-BinRoot
	$installPath = Join-Path $binRoot "Foldit"
	$silentArgsBase = '/S /D='
	$working_dir = "."
	$install_fname = 'foldit.exe'
	Write-host 'Download'
	Invoke-WebRequest -Uri $release -OutFile "$working_dir\$install_fname"
	Write-host 'Install'
	. $working_dir/$install_fname $silentArgs
	
	$version=Get-Version('foldit')
	Write-host "Version : $version"
	$url32 = $release
	
	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32