$url32          = 'https://github.com/fernandreu/office-ribbonx-editor/releases/download/v1.7.1/OfficeRibbonXEditor-Installer-NETFramework.exe'
$checksum32     = 'ac799ca9064a1c13fb9887c91eddad54aa53e2175e8206aa02c16bfdec66556d'
$checksumType32 = 'sha256'

$packageArgs = @{
    packageName            = $env:ChocolateyPackageName
    fileType               = 'EXE'
    url                    = $url32
    checksum               = $checksum32
    checksumType           = $checksumType32
    silentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    validExitCodes         = @(0)
}

Install-ChocolateyPackage @packageArgs
