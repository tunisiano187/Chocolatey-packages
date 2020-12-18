; default environment
DetectHiddenWindows, off
SetControlDelay, 20

; modified environment
#NoEnv
DetectHiddenText, off
SetTitleMatchMode, 1  ;begins

WinWait, Windows Security ahk_class #32770, , 40
WinActivate Windows Security ahk_class #32770
Send {AltDown}I{AltUp}
Send {enter}

ExitApp