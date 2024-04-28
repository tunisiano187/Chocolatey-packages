#NoEnv
#NoTrayIcon
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetTitleMatchMode, 1  ; A windows's title must start with the specified WinTitle to be a match.
SetControlDelay 0  
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;winTitle1 = Acronis Drive Monitor ahk_class #32770 ahk_exe ADM_en-US.exe
winTitle1 = Acronis Drive Monitor

WinWait, %winTitle1%,v.1.0.566, 180
MouseMove, 523, 176
Sleep 750
ControlClick, x523 y176, %winTitle1% ; Install Acronis Drive Monitor

WinWait, %winTitle1%,Welcome to Acronis Drive Monitor Setup!, 10
Sleep 350
ControlClick, Button2, %winTitle1% ; Next >
Sleep 350
ControlClick, Button4, %winTitle1% ; I accept the terms of this agreement
Sleep 350
ControlClick, Button2, %winTitle1% ; Next >
Sleep 350
ControlClick, Button2, %winTitle1% ; Next >
Sleep 350
ControlClick, Button2, %winTitle1% ; Install
Sleep 350
WinWait, %winTitle1%,Installation has completed., 60
ControlClick, Button2, %winTitle1% ; Close

Sleep 750
;Send {Esc}
MouseMove, 715, 17
ControlClick, x715 y17, %winTitle1% ; Close main window