#NoEnv
#NoTrayIcon
SendMode Input
DetectHiddenText, off  ;toggle search hidden window text
DetectHiddenWindows, off  ;toggle detect hidden windows
SetTitleMatchMode, 2   ;contains

winTitle = Windows Security ahk_class #32770

; Adafruit LLC Ports
WinWait, %winTitle%, ,300
WinActivate
ControlClick, &Install, %winTitle%

Sleep, 100

; Arduino USB Driver
WinWait, %winTitle%
WinActivate
ControlClick, &Install, %winTitle%
Sleep, 100
WinWait, %winTitle%
WinActivate
ControlClick, &Install, %winTitle%

ExitApp