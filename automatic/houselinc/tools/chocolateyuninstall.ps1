$ErrorActionPreference = 'Stop';
$packageName = 'houselinc'
$packageSearch = 'HouseLinc'
$installerType = 'msi'
$silentArgs = '/quiet /qn /norestart'
$validExitCodes = @(0)
$uninstalled = $false

if((get-process "HouseLinc" -ea SilentlyContinue) -eq $Null){
        echo "HouseLinc not running... Good."
}
else{
    echo "Stopping HouseLinc..."
    Stop-Process -processname "HouseLinc"
	Start-Sleep -s 2
 }

try {
  Get-ItemProperty -Path @( 'HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*',
                            'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*',
                            'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*' ) `
                   -ErrorAction:SilentlyContinue `
  | Where-Object   { $_.DisplayName -like "$packageSearch*" } `
  | ForEach-Object { Uninstall-ChocolateyPackage -PackageName "$packageName" `
                                                 -FileType "$installerType" `
                                                 -SilentArgs "$($_.PSChildName) $silentArgs" `
                                                 -ValidExitCodes $validExitCodes }
} catch {
  throw $_.Exception
}
