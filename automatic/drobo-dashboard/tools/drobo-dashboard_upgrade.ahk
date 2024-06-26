#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

WinWaitActive, Drobo Dashboard - InstallShield Wizard , This setup will perform an upgrade , 90
WinActivate
Send !y

sleep, 15000 

;WinWaitActive, Drobo Dashboard - InstallShiled Wizard, Resuming the InstallShield Wizard for Drobo Dashboard , 90
;WinActivate
Send !n
Send {up}
Send !n
Send !n
Send !n
Send !i
sleep, 15000
Send {tab}
Send {space}
Send !f