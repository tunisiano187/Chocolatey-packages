#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;BlockInput On 
WinWaitActive, 4Team OST2, Select the language for the installation, 60
WinActivate
Send !o
WinWaitActive, 4Team OST2, Welcome to the InstallShield Wizard for 4Team OST2, 60
WinActivate
Send !n
Send !a
Send !n
WinWaitActive, 4Team OST2, InstallShield Wizard Completed, 30
WinActivate
Send {Tab}
Send {Space}
Send !f
;BlockInput Off

