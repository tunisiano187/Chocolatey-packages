$packageName    = $env:ChocolateyPackageName
$installerType  = 'exe'
$url32          = 'https://sourceforge.net/projects/tigervnc/files/stable/1.13.1/tigervnc-1.13.1.exe/download'
$url64          = 'https://sourceforge.net/projects/tigervnc/files/stable/1.13.1/tigervnc64-1.13.1.exe/download'
$checksum32     = '@{Algorithm=SHA256; Hash=60E7E26FA996BE70156747941D7FB92D116D1CCC442614192BB96DF20CA599E6; Path=C:\Users\Admin\AppData\Local\Temp\tigervnc.exe}'
$checksum64     = '@{Algorithm=SHA256; Hash=536CA6BCF77C8EE3FBFFE294A25269BB9D1D26B038BDB682FD3161E6C7FDA3F3; Path=C:\Users\Admin\AppData\Local\Temp\tigervnc64.exe}'
$checksumType   = 'SHA256'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes = @(0)
$options =
@{
  Headers = @{
    UserAgent = 'Wget';
  }
}

$packageArgs = @{
    packageName     = $packageName
    fileType        = $installerType
    softwareName    = "$packageName*"

    checksum        = $checksum32
    checksumType    = $checksumType
    url             = $url32
    options         = $options

    checksum64      = $checksum64
    checksumType64  = $packageName
    url64bit        = $url64

    silentArgs      = $silentArgs
    validExitCodes  = $validExitCodes
}

Install-ChocolateyPackage $packageArgs
