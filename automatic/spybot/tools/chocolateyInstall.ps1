$packageName = $env:ChocolateyPackageName
$installerType = 'exe'
$silentArgs = '/VERYSILENT /NORESTART /SP-'
$url = 'https://updates2.safer-networking.org/spybot1/spybotsd-2.8.68.0.exe'
$checksum = '647cfdf796154ba0ce1786fd72f62102653f6fbfcc982e25da26579b844d966a'
$checksumType = 'sha256'
$validExitCodes = @(0)
$options =
@{
  Headers = @{
    Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8';
    'Accept-Charset' = 'ISO-8859-1,utf-8;q=0.7,*;q=0.3';
    'Accept-Language' = 'en-GB,en-US;q=0.8,en;q=0.6';
    Cookie = 'requiredinfo=info';
    Referer = 'https://www.safer-networking.org/products/spybot-free-edition/download-mirror-1/';
  }
}

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType" `
                          -Options $options
