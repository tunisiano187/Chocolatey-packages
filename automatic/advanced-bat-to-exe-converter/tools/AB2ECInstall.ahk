#NoEnv 
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

WinWaitActive, Installing Advanced BAT to EXE Converter , , 600
WinActivate
Send !a
Send !n
Send !n
;WinWaitActive, Advanced BAT to EXE Converter v4.23 , , 300
;WinActivate
;Send !{F4}
WinWaitActive, Application Installed , , 300
WinActivate
Send {SPACE}
