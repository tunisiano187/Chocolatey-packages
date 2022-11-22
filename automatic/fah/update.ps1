$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://download.foldingathome.org/releases/public/release/fah-installer/windows-10-32bit/'

function Get-Version($name) {
	$version_file=$(../../tools/Get-InstalledApps.ps1 -ComputerName $env:COMPUTERNAME -NameRegex $name).DisplayVersion
	while($version_file.count -eq 0)
	{
		$version_file=$(../../tools/Get-InstalledApps.ps1 -ComputerName $env:COMPUTERNAME -NameRegex $name).DisplayVersion
		Start-Sleep -Seconds 1
	}
	return $version_file
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
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
	$version_folder = ((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object  {$_.href -match '^v\d+([.]\d+)?'} | ForEach-Object {($_.href -replace '[^.\d]', '')} | Measure-Object -Max).Maximum
	$installer = "$($releases)v$($version_folder)/latest.exe"
	$working_dir = "."
	$install_fname = 'folding_installer.exe'
	Write-Output 'Download'
	Invoke-WebRequest -Uri $installer -OutFile "$working_dir\$install_fname"
	Write-Output 'Install'
	. $working_dir/$install_fname /S
	$version=Get-Version('folding')
	Write-Output "Version : $version"
	$url32 = "$($releases)v$($version_folder)/fah-installer_$($version)_x86.exe"

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32
