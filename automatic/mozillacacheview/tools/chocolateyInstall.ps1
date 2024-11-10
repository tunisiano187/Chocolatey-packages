$ErrorActionPreference = 'Stop'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$file32         = "$(Join-Path $toolsDir -ChildPath 'mzcacheview.zip')"

$unzipArgs = @{
    PackageName     = $env:ChocolateyPackageName
    FileFullPath    = $file32
    Destination     = $toolsDir
}

Get-ChocolateyUnzip @unzipArgs

$installFile    = (get-childitem -Filter "*.exe" -Recurse).FullName

Set-Content -Path ("$installFile.gui") `
            -Value $null