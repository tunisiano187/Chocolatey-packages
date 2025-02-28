$ErrorActionPreference = 'Stop'; # stop on all errors	$uninstaller = $(./Get-InstalledApps.ps1 -NameRegex Fing).UninstallString.split('"')[1]
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'Fing'  #part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique
  fileType      = 'EXE' #only one of these: MSI or EXE (ignore MSU for now)

  silentArgs    = "/allusers /S"
  validExitCodes= @(0, 3010, 1605, 1614, 1641) # https://msdn.microsoft.com/en-us/library/aa376931(v=vs.85).aspx
}

Uninstall-ChocolateyPackage @packageArgs
