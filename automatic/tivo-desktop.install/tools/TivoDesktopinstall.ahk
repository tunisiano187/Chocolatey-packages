#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
 
WinWait, TiVo Desktop 2.8.3 Installer, , 60
WinActivate
;BlockInput On
Send !y
Sleep, 300
WinWait, TiVo Desktop 2.8.3 Installer, Please select the location where this software will be used: , 60
WinActivate
Send {Enter}
WinWait, TiVo Desktop 2.8.3 Installer,Which kinds of DVRs will TiVo Desktop be used for: , 60
WinActivate
Send {Enter}
Sleep, 100
Send !n
Sleep, 100
Send !a
Send !n
Send !n
Send !n
Send !n
Send !n
Send !n
Send !n
Sleep, 10000
Send !n
Sleep, 500
WinWait, TiVo Desktop 2.8.3 Installer,Additional Software Needed,60
WinActivate
Send !n 
WinWait, TiVo Desktop 2.8.3 Installer,TiVo Desktop 2.8.3 has been successfully installed.,60
WinActivate
Send !f
;BlockInput Off
