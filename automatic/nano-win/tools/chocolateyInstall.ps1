$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$file           = (Get-ChildItem -Path $toolsDir -Filter '*.7z').FullName

$packageArgs = @{
    packageName   = $packageName
    unzipLocation = $toolsDir
    file          = $file
}

Install-ChocolateyZipPackage @packageArgs
