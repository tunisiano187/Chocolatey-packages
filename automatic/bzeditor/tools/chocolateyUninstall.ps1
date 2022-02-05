try {
  $processor = Get-WmiObject Win32_Processor
  $is64bit = $processor.AddressWidth -eq 64
  if ($is64bit) {
    $unpath = "${Env:ProgramFiles(x86)}\BzEditor\uninst.exe"
  } else {
    $unpath = "${Env:ProgramFiles}\BzEditor\uninst.exe"
  }
  Uninstall-ChocolateyPackage 'bzeditor' 'EXE' '/S' "$unpath" -validExitCodes @(0)
  
  # the following is all part of error handling
  Write-ChocolateySuccess 'bzeditor'
} catch {
  Write-ChocolateyFailure 'bzeditor' "$($_.Exception.Message)"
  throw 
}