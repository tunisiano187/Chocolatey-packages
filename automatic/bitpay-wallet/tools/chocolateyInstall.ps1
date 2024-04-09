$packageName    = $env:ChocolateyPackageName
$installerType  = 'exe'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$url            = 'https://github.com/bitpay/copay/releases/download/v4.6.2/BitPay.exe'
$checksum       = '6600d8c89215d23f28772d2e8df6708b4b0defd4edb09e5bc00b265887b9564c'
$checksumType   = 'sha256'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName $packageName `
                          -FileType $installerType `
                          -SilentArgs $silentArgs `
                          -Url $url `
                          -ValidExitCodes $validExitCodes `
                          -Checksum $checksum `
                          -ChecksumType $checksumType