$url32          = 'https://github.com/fernandreu/office-ribbonx-editor/releases/download/v1.9.0/OfficeRibbonXEditor-NETFramework-Installer.exe'
$checksum32     = '97a3c53a2ee1e81fc58e3322c55331fac228dfba7d64a26645558200da1a4970'
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
