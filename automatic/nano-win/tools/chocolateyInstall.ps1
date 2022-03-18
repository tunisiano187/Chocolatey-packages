$packageName    = $env:ChocolateyPackageName
$file           = 'nano-win_9986_v6.2-16-g58bbad01a.7z'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
    packageName   = $packageName
    unzipLocation = $toolsDir
    file          = Join-Path $toolsDir $file
}

Install-ChocolateyZipPackage @packageArgs
