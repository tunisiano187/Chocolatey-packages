$ErrorActionPreference = 'Stop'
If (Test-Path c:\Snort){
   Remove-Item -path c:\Snort -recurse
}
