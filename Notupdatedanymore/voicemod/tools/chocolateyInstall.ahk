; environment
#NoEnv
#NoTrayIcon
SendMode Input
DetectHiddenText, off  ;toggle search hidden window text
DetectHiddenWindows, off  ;toggle detect hidden windows
SetTitleMatchMode, 2   ;contains
settimer, security

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

security:
WinWait, Security Alert
WinActivate
ControlClick, Yes, Security Alert