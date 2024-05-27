#NoEnv 
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
 
WinWaitActive, Pelles C 8.00 Add-In SDK Setup, Choose Install Location , 600
WinActivate
Send {Space}
WinWaitActive, Pelles C 8.00 Add-In SDK Setup, Finished , 600
Send {Space}
