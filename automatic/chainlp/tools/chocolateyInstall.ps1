try {
  $downUrl = 'http://chainlp.o.oo7.jp/ChainLP40b17.zip'
  $toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

  Install-ChocolateyZipPackage 'chainlp' "$downUrl" "$toolsDir" 

  Write-ChocolateySuccess 'chainlp'
} catch {
  Write-ChocolateyFailure 'chainlp' "$($_.Exception.Message)"
  throw 
}
