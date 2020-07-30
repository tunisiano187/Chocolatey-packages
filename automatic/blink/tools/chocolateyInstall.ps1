$packageName        = $env:ChocolateyPackageName
$installerType      = 'exe'
$silentArgs         = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes     = @(0)
$url                = '{{DownloadUrl}}'
$checksum           = '{{Checksum}}'
$checksumType       = 'md5'
$referer            = 'http://icanblink.com/download/'

$options =
@{
  Headers = @{
    Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8';
    'Accept-Charset' = 'ISO-8859-1,utf-8;q=0.7,*;q=0.3';
    'Accept-Language' = 'en-GB,en-US;q=0.8,en;q=0.6';
    Cookie = 'requiredinfo=info';
    Referer = $referer;
  }
}
Set-UseUnsafeHeaderParsing -Enable
Invoke-WebRequest -Uri $referer -OutFile "$env:TEMP/icanblink.html"  #  Required to be allowed just after
Set-UseUnsafeHeaderParsing -Enable
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -validExitCodes $validExitCodes -checksum "$checksum" -checksumType "$checksumType" -Options $options
