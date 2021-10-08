$url32          = 'https://github.com/fernandreu/office-ribbonx-editor/releases/download/v1.8.0/OfficeRibbonXEditor-NETFramework-Installer.exe'
$checksum32     = 'ff57d64725825fdaebdbeaf2fd663e80b0a6b85c92ebdd6a1f74be4a44f9e4b0'
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
