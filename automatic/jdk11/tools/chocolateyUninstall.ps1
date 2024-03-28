$script_path = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$common = $(Join-Path $script_path "common.ps1")
. $common
 
function Uninstall-ChocolateyPath {
param(
  [string] $pathToUninstall,
  [System.EnvironmentVariableTarget] $pathType = [System.EnvironmentVariableTarget]::User
)
  Write-Debug "Running 'Uninstall-ChocolateyPath' with pathToUninstall:`'$pathToUninstall`'";
   
  #get the PATH variable
  $envPath = $env:PATH
  if ($envPath.ToLower().Contains($pathToUninstall.ToLower()))
  {
    Write-Host "PATH environment variable has $pathToUninstall in it. Removing..."
    $actualPath = [Environment]::GetEnvironmentVariable('Path', $pathType)
 
    $statementTerminator = ";"
    # remove $pathToUninstall
    $actualPath = (($actualPath -split $statementTerminator) -ne $pathToUninstall) -join $statementTerminator
 
    if ($pathType -eq [System.EnvironmentVariableTarget]::Machine) {
      $psArgs = "[Environment]::SetEnvironmentVariable('Path',`'$actualPath`', `'$pathType`')"
      Start-ChocolateyProcessAsAdmin "$psArgs"
    } else {
      [Environment]::SetEnvironmentVariable('Path', $actualPath, $pathType)
    }    
     
    #add it to the local path as well so users will be off and running
    $env:Path = $actualPath
  }
}
 
$java_bin = get-java-bin
Uninstall-ChocolateyPath $java_bin 'Machine'
if ([Environment]::GetEnvironmentVariable('CLASSPATH','Machine') -eq '.;') {
    Install-ChocolateyEnvironmentVariable 'CLASSPATH' $null 'Machine'
}
Install-ChocolateyEnvironmentVariable 'JAVA_HOME' $null 'Machine'
