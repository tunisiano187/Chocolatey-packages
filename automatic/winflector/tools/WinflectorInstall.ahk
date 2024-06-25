#NoEnv 
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
 
;BlockInput On 
WinWaitActive, Setup,Would you like to enable Winflector server in Windows Firewall?, 180 
WinActivate
Send !y

WinWaitActive,Windows Security,, 30
WinActivate
Send !i
 
WinWaitActive, Setup,Winflector printer driver has not been installed properly, 10
WinActivate
Send {Enter}
 
WinWaitActive, Setup - Winflector,, 30
WinActivate
Send !n
Send !a
Send !n
Send !n
Send !n
Send !n
Send !i
;BlockInput Off
