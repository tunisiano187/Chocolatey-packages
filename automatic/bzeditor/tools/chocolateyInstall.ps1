#try {
  $downUrl = 'http://binaryeditorbz.googlecode.com/files/BzEditor-1.7.6.exe'
  # installer, will assert administrative rights
  Install-ChocolateyPackage 'bzeditor' 'EXE' '/S' "$downUrl" -validExitCodes @(0)
  
  # the following is all part of error handling
  #Write-ChocolateySuccess 'bzeditor'
#} catch {
  #Write-ChocolateyFailure 'bzeditor' "$($_.Exception.Message)"
  #throw 
#}