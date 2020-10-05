$packageName= $env:ChocolateyPackageName

$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$softwareDir  = "$toolsDir/nteract"
$softwareExe  = "$softwareDir/nteract.exe"

$url          = ''
$checksum     = '65e13464287c27a964a9d614a2171b2dff3224db39a968cd8b1f3a0b5a8ccbc9'
$checksumType = ''

$packageArgs = @{
  PackageName   = $packageName
  Url           = $url
  UnzipLocation = $toolsDir
  ChecksumType  = $checksumType
  Checksum      = $checksum
}

Install-ChocolateyZipPackage @packageArgs

 # Rename unzipped folder
Rename-Item "$toolsDir\win-unpacked" "$softwareDir"

# Don't create shims for anything other than main exe
$files = get-childitem "$toolsDir" -include *.exe -exclude 'nteract.exe' -recurse
foreach ($file in $files) {
  New-Item "$file.ignore" -type file -force | Out-Null
}

# Create desktop shortcut
$desktop = $([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::DesktopDirectory))
$link = Join-Path $desktop 'nteract.lnk'
if (!(Test-Path $link)) {
    Install-ChocolateyShortcut -ShortcutFilePath "$link" -TargetPath "$softwareExe" -WorkingDirectory "$softwareDir"
}

# Associate file extension
Install-ChocolateyFileAssociation -Extension '.ipynb' -Executable "$softwareExe"


# Install ipykernel to get started directly
Start-ChocolateyProcessAsAdmin "&python -m pip install ipykernel"
Start-ChocolateyProcessAsAdmin "&python -m ipykernel install --user"
