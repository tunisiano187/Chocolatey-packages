#NoEnv 
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
 
WinWaitActive, Uninstall,, 60
WinActivate
BlockInput On
Send !y
BlockInput Off

