$packageName    = $env:ChocolateyPackageName
$file           = 'https://files.lhmouse.com/nano-win/nano-win_9986_v6.2-16-g58bbad01a.7z'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
    packageName     = $packageName
    Destination     = $toolsDir
    file            = Join-Path $toolsDir $file
}

Get-ChocolateyUnzip @packageArgs
