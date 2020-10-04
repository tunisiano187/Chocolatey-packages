; default environment
DetectHiddenWindows, off
SetControlDelay, 20

; modified environment
#NoEnv
DetectHiddenText, off
SetTitleMatchMode, 1  ;begins

WinWait, Windows Security ahk_class #32770, , 40
ControlClick, Button1, Windows Security ahk_class #32770, &Install

ExitApp