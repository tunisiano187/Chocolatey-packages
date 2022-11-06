$File         = 'MobaLiveCD_v2.1.exe'
if(Test-Path "$env:USERPROFILE\desktop\$File") {
    Remove-Item "$env:USERPROFILE\desktop\$File"
}
