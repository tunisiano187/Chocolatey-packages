$File         = ''
if(Test-Path "$env:USERPROFILE\desktop\$File") {
    Remove-Item "$env:USERPROFILE\desktop\$File"
}