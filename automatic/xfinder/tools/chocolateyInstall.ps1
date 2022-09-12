try {
  $downUrl = "http://www.eonet.ne.jp/~gakana/download/dl/xf11-11.cab"
  $parentpath = "$(Split-Path -parent $(Split-Path -parent $MyInvocation.MyCommand.Definition))"
  Get-ChocolateyWebFile 'xfinder' "${parentpath}\xfinder.cab" "$downUrl"
  $cmd7z = "${Env:ProgramFiles}\7-Zip\7z.exe"
  Start-Process -FilePath "$cmd7z" -Wait -WorkingDirectory "${parentpath}\tools" -ArgumentList "x ${parentpath}\xfinder.cab"

  $target = Join-Path $parentpath 'tools\xf.exe'
  Install-ChocolateyDesktopLink $target
  
  Write-ChocolateySuccess 'xfinder'
} catch {
  Write-ChocolateyFailure 'xfinder' "$($_.Exception.Message)"
  throw 
}
