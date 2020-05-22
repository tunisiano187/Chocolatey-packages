$installer_url = 'https://download.foldingathome.org/releases/public/release/fah-installer/windows-10-32bit/'
Write-host 'Check Folder'
$version = ((Invoke-WebRequest -Uri $installer_url -UseBasicParsing).Links | Where-Object  {$_.href -match '^v\d+([.]\d+)?'} | ForEach-Object {($_.href -replace '[^.\d]', '')} | Measure-Object -Max).Maximum
$installer = "$($installer_url)v$($version)/latest.exe"
$working_dir = "."
$install_fname = 'folding_installer.exe'
Write-host 'Download'
Invoke-WebRequest -Uri $installer -OutFile "$working_dir\$install_fname"
Write-host 'Install'
. $working_dir/$install_fname /S
$version_file=$(tools/Get-InstalledApps.ps1 -ComputerName $env:COMPUTERNAME -NameRegex 'folding').DisplayVersion
while($version_file.count -eq 0)
{
	$version_file=$(tools/Get-InstalledApps.ps1 -ComputerName $env:COMPUTERNAME -NameRegex 'folding').DisplayVersion
	Write-host "Loop"
	Start-Sleep -Seconds 5
}
Write-host "Version : $version_file"
$installer_url = "$($installer_url)v$($version)/fah-installer_$($version_file)_x86.exe"
Write-host 'Check SHA1'
$sha1=$(checksum "$working_dir\$install_fname" -t sha1)
$sha1

Write-host 'Updating files'

tools/Replace-FileString.ps1 "~url~" $installer_url fah/tools/chocolateyInstall.ps1 -Overwrite
tools/Replace-FileString.ps1 "~sha1~" $sha1 fah/tools/chocolateyInstall.ps1 -Overwrite
tools/Replace-FileString.ps1 "7.6.9" $version_file fah/fah.nuspec -Overwrite
tools/Replace-FileString.ps1 "7.6.9" $version_file .gitlab-ci.yml -Overwrite
tools/Replace-FileString.ps1 "7.6.9" $version_file upload.ps1 -Overwrite