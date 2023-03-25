$packageName    = $env:ChocolateyPackageName
$installerType  = 'exe'
$url32          = 'https://bintray.com/tigervnc/stable/download_file?file_path=tigervnc-1.11.0.exe'
$url64          = 'https://bintray.com/tigervnc/stable/download_file?file_path=tigervnc64-1.11.0.exe'
$checksum32     = 'fc7a4b4195870595eb280ccf77a528f8d252c113d469331ebed23b1b591554e5fe7ed6cbf6f1187b315df37efcc867cbb3143fafe4e926a6a79eaa9a7401e3e2'
$checksum64     = '443fc186837fefcd9b2d50159a82087aeb8dbb28f8bd255c2c724dcc49584615b56bfd42cb86aff1ae151669893617037fa600000449e270955743975d9ce2fe'
$checksumType   = 'sha512'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes = @(0)

$packageArgs = @{
    packageName     = $packageName
    fileType        = $installerType
    softwareName    = "$packageName*"

    checksum        = $checksum32
    checksumType    = $checksumType
    url             = $url32

    checksum64      = $checksum64
    checksumType64  = $packageName
    url64bit        = $url64

    silentArgs      = $silentArgs
    validExitCodes  = $validExitCodes
}

Install-ChocolateyPackage $packageArgs
