$url32          = 'http://sourceforge.net/projects/openstego/files/openstego/openstego-0.6.1/Setup-OpenStego-0.6.1.exe/download'
$checksum32     = 'c343f8dadb6ca89e42a0d43bca36161d95f952a4'
$checksumType32 = 'sha1'

$packageArgs = @{
    packageName            = $env:ChocolateyPackageName
    fileType               = 'EXE'
    url                    = $url32
    checksum               = $checksum32
    checksumType           = $checksumType32
    silentArgs             = '/S'
    validExitCodes         = @(0)
}

Install-ChocolateyPackage @packageArgs