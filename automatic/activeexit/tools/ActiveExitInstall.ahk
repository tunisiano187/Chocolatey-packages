#NoEnv 
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
 
WinWaitActive, ActiveExit , accept the terms in the License Agreement, 600
WinActivate
Send !a
Send !i
WinWaitActive, ActiveExit, Click the Finish button to exit the Setup Wizard., 60
Send !f


