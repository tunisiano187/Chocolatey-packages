$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installDir = "$(Get-ToolsLocation)"

$file       = (Get-ChildItem -Path $toolsDir -Filter "*.7z").FullName

$packageArgs = @{
    packageName     = $env:ChocolateyPackageName
    unzipLocation   = $installDir

    File            = $file
}

Install-ChocolateyZipPackage @packageArgs

$psfile     = Join-Path "$toolsDir" "hashcat.ps1"
Install-ChocolateyPowershellCommand -PackageName "hashcat" -PSFileFullPath "$psfile"