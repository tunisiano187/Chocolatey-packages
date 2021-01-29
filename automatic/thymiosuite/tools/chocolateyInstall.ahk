; default environment
DetectHiddenWindows, off
SetControlDelay, 20

; modified environment
#NoEnv
DetectHiddenText, off
SetTitleMatchMode, 1  ;begins

winTitle = Windows Security ahk_class #32770

; Drivers install

WinWait, %winTitle%
WinActivate
ControlClick, &Install, %winTitle%
Sleep, 100
WinWait, %winTitle%
WinActivate
ControlClick, &Install, %winTitle%
Sleep, 100
WinWait, %winTitle%
WinActivate
ControlClick, &Install, %winTitle%
Sleep, 100

ExitApp