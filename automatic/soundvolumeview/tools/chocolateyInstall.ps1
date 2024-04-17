$ErrorActionPreference = 'Stop'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$file32         = "$(Join-Path $toolsDir -ChildPath 'soundvolumeview.zip')"
$file64         = "$(Join-Path $toolsDir -ChildPath 'soundvolumeview-x64.zip')"

$unzipArgs = @{
    PackageName     = $env:ChocolateyPackageName
    FileFullPath    = $file32
    FileFullPath64  = $file64
    Destination     = $toolsDir
}

Get-ChocolateyUnzip @unzipArgs

$installFile    = (get-childitem -Filter "*.exe" -Recurse).FullName

Set-Content -Path ("$installFile.gui") `
            -Value $null