try {
  $toolsDir     = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
  $url          = 'http://mobalivecd.mobatek.net/en/MobaLiveCD_v2.1.exe'
  $checksum     = ''
  $checksumType = ''

  #Install-ChocolateyPackage 'mobalivecd' 'EXE' '/SILENT' "$downUrl" -validExitCodes @(0)

  $packageArgs = @{
    packageName     = $env:ChocolateyPackageName
    url             = $url
    checksum        = $checksum
    checksumType    = $checksumType
    FileFullPath    = "${toolsDir}\MobaLiveCD_v2.1.exe"
  }

  Get-ChocolateyWebFile @packageArgs
  Install-ChocolateyDesktopLink "${toolsDir}\MobaLiveCD_v2.1.exe"
} catch {
  throw "$($_.Exception.Message)"
}
