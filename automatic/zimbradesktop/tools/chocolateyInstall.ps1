$packageName        = 'zimbra-desktop'
$installerType      = 'exe'
$silentArgs         = '/S'
$url                = 'https://files.zimbra.com/downloads/zxui/4.50.0/Zimbra_Desktop_4.50.0_1c29dbde6_20260828104135.exe'
$checksum           = '80c1d73122b48eaeb7bb04c17390cdaa35f2e2376d07be8a8696c1fc26e6a7cc'
$checksumType       = 'sha256'
$validExitCodes     = @(0)

$MinimumWindowsVersion = "10.0.0"
if((Get-CimInstance win32_operatingsystem).Version -lt $MinimumWindowsVersion) {
    Write-Error "Windows 10 or higher required"
}

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType"
