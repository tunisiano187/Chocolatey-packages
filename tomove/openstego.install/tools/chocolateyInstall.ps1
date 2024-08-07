$url32          = 'https://github.com/syvaidya/openstego/releases/download/openstego-0.8.6/Setup-OpenStego-0.8.6.exe'
$checksum32     = '80cfa3fe262219ce5e68d255477042e1473aa3ae97552d7bad8e895c95b44a73'
$checksumType32 = 'sha256'

$packageArgs = @{
    packageName            = $env:ChocolateyPackageName
    fileType               = 'EXE'
    url                    = $url32
    checksum               = $checksum32
    checksumType           = $checksumType32
    silentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP- /ALLUSERS'
    validExitCodes         = @(0)
}

Install-ChocolateyPackage @packageArgs
