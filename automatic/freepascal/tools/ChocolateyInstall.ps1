$ErrorActionPreference = 'Stop'

$PackageName    = 'freepascal'
$Url32          = 'https://sourceforge.net/projects/freepascal/files/Win32/3.2.2/fpc-3.2.2.i386-win32.exe/download'
$checksum       = '7ec78b1790ecac7685f440b17f9e03865bc09846b7c068a9270c4d37704b5ac8'
$checksumType   = 'sha256'
$Url64          = 'https://sourceforge.net/projects/freepascal/files/Win32/3.2.2/fpc-3.2.2.win32.and.win64.exe/download'
$checksum64     = ''
$checksumType64 = ''

$ToolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$InstallationPath = Join-Path $(Get-ToolsLocation) $PackageName

$SetupInfPath = Join-Path $ToolsPath 'setup.inf'
(Get-Content $SetupInfPath).replace('%InstallationPath%', $InstallationPath) | Set-Content $SetupInfPath

$SilentArgs = "/verysilent /norestart /LoadInf=`"$SetupInfPath`""

$PackageArgs = @{
    PackageName     = $PackageName
    Url             = $Url32
    Checksum        = $checksum
    ChecksumType    = $checksumType
    SilentArgs      = $SilentArgs
}
Install-ChocolateyPackage @PackageArgs

if ((Get-OSArchitectureWidth 64) -and $Env:ChocolateyForceX86 -ne 'true') {
    $PackageArgs = @{
        PackageName     = $PackageName
        Url64           = $Url64
        Checksum64      = $checksum64
        ChecksumType64  = $checksumType64
        SilentArgs      = $SilentArgs
    }
    Install-ChocolateyPackage @PackageArgs
}

$BinPath = Join-Path $InstallationPath 'bin\i386-win32'
Install-ChocolateyPath -PathToInstall $BinPath -PathType 'Machine'
